package com.ad.ui {
	import com.ad.events.KeyComboEvent;
	import com.ad.events.EventControl;
	import com.ad.utils.ArrayUtil;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	[Event(name = 'KeyComboEvent.KEY_COMBO_TYPED', type = 'com.ad.events.KeyComboEvent')]
	[Event(name = 'KeyComboEvent.KEY_COMBO_DOWN', type = 'com.ad.events.KeyComboEvent')]
	[Event(name = 'KeyComboEvent.KEY_COMBO_UP', type = 'com.ad.events.KeyComboEvent')]
	[Event(name = 'KeyComboEvent.KEY_DOWN', type = 'com.ad.events.KeyComboEvent')]
	[Event(name = 'KeyComboEvent.KEY_UP', type = 'com.ad.events.KeyComboEvent')]
	
	public class KeyboardControl extends EventControl {
		public static var shortcutTarget:KeyboardControl = new KeyboardControl();
		protected var stage:Stage;
		protected var combos:Vector.<KeyCombo>;
		protected var combosDown:Vector.<KeyCombo>;
		protected var keysTyped:Array;
		protected var keysDown:Dictionary;
		protected var longestCombo:uint;
		
		public function KeyboardControl() {
			this.combos = new Vector.<KeyCombo>();
			this.combosDown = new Vector.<KeyCombo>();
			this.keysTyped = new Array();
			this.keysDown = new Dictionary(true);
			this.longestCombo = 0;
		}
		
		public function initialize(stage:Stage):void {
			this.stage = stage;
			this.stage.addEventListener(Event.DEACTIVATE, this.onDeactivate);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		}
		
		public function finalize():void {
			this.stage.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		}
		
		public function addCombo(keyCombo:KeyCombo):void {
			if (this.combos.indexOf(keyCombo) != -1) {
				trace(this.toString(), keyCombo.toString(), 'combo already exists.');
				return;
			}
			this.longestCombo = Math.max(this.longestCombo, keyCombo.keyCodes.length);
			this.combos.push(keyCombo);
		}
		
		public function removeCombo(keyCombo:KeyCombo):void {
			var index:int = this.combos.indexOf(keyCombo);
			if (index == -1) {
				trace(this.toString(), keyCombo.toString(), 'combo doesn\'t exist.');
				return;
			}
			this.combos.splice(index, 1);
			if (keyCombo.keyCodes.length == this.longestCombo) {
				var size:uint = 0;
				var total:uint = this.combos.length;
				while (total--) {
					size = Math.max(size, this.combos[total].keyCodes.length);
				}
				this.longestCombo = size;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			var alreadyDown:Boolean = this.keysDown[event.keyCode];
			this.keysDown[event.keyCode] = true;
			this.keysTyped.push(event.keyCode);
			if (this.keysTyped.length > this.longestCombo) {
				this.keysTyped.splice(0, 1);
			}
			var id:uint = this.combos.length;
			while (id--) {
				this.checkTypedKeys(this.combos[id]);
				if (!alreadyDown) {
					this.checkDownKeys(this.combos[id]);
				}
			}
			var keyDown:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_DOWN);
			keyDown.keyCode = event.keyCode;
			super.dispatchEvent(keyDown);
		}
	
		private function onKeyUp(event:KeyboardEvent):void {
			var id:uint = this.combosDown.length;
			while (id--) {
				if (this.combosDown[id].keyCodes.indexOf(event.keyCode) != -1) {
					var keyComboHold:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_COMBO_UP);
					keyComboHold.keyCombo = this.combosDown[id];
					this.combosDown.splice(id, 1);
					super.dispatchEvent(keyComboHold);
				}
			}
			delete this.keysDown[event.keyCode];
			var keyUp:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_UP);
			keyUp.keyCode = event.keyCode;
			super.dispatchEvent(keyUp);
		}
		
		private function onDeactivate(event:Event):void {
			var id:uint = this.combosDown.length;
			while (id--) {
				var keyComboHold:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_COMBO_UP);
				keyComboHold.keyCombo = this.combosDown[id];
				super.dispatchEvent(keyComboHold);
			}
			this.combosDown = new Vector.<KeyCombo>();
			this.keysDown = new Dictionary(true);
		}
		
		private function checkDownKeys(keyCombo:KeyCombo):void {
			var uniqueCombo:Array = ArrayUtil.removeDuplicates(keyCombo.keyCodes);
			var id:uint = uniqueCombo.length;
			while (id--) if (!this.keysDown[uniqueCombo[id]]) return;
			var keyComboDown:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_COMBO_DOWN);
			keyComboDown.keyCombo = keyCombo;
			this.combosDown.push(keyCombo);
			super.dispatchEvent(keyComboDown);
		}
		
		private function checkTypedKeys(keyCombo:KeyCombo):void {
			if (ArrayUtil.strictlyEquals(keyCombo.keyCodes, this.keysTyped.slice(-keyCombo.keyCodes.length))) {
				var keyComboSeq:KeyComboEvent = new KeyComboEvent(KeyComboEvent.KEY_COMBO_TYPED);
				keyComboSeq.keyCombo = keyCombo;
				super.dispatchEvent(keyComboSeq);
			}
		}
		
		override public function toString():String {
			return '[KeyboardControl]';
		}
	}
}