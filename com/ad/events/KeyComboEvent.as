package com.ad.events {
	import com.ad.ui.KeyCombo;
	
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class KeyComboEvent extends KeyboardEvent {
		public static const KEY_COMBO_TYPED:String = 'KeyComboEvent.KEY_COMBO_TYPED';
		public static const KEY_COMBO_DOWN:String = 'KeyComboEvent.KEY_COMBO_DOWN';
		public static const KEY_COMBO_UP:String = 'KeyComboEvent.KEY_COMBO_UP';
		public static const KEY_DOWN:String = 'KeyComboEvent.KEY_DOWN';
		public static const KEY_UP:String = 'KeyComboEvent.KEY_UP';
		private var _keyCombo:KeyCombo;
		
		public function KeyComboEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function get keyCombo():KeyCombo {
			return this._keyCombo;
		}
		
		public function set keyCombo(keyCombo:KeyCombo):void {
			this._keyCombo = keyCombo;
		}
		
		override public function clone():Event {
			var event:KeyComboEvent = new KeyComboEvent(super.type, super.bubbles, super.cancelable);
			event.keyCombo = this.keyCombo;
			return event;
		}
		
		override public function toString():String {
			return super.formatToString('KeyComboEvent', 'type', 'bubbles', 'cancelable', 'keyCombo', 'eventPhase');
		}
	}
}