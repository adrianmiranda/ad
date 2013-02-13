package com.ad.templates {
	import com.ad.interfaces.IButton;
	import com.ad.display.Leprechaun;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	[Event(name = 'active', type = 'flash.events.MouseEvent')]
	[Event(name = 'click', type = 'flash.events.MouseEvent')]
	[Event(name = 'over', type = 'flash.events.MouseEvent')]
	[Event(name = 'out', type = 'flash.events.MouseEvent')]
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class ButtonLite extends Leprechaun implements IButton {
		private static var BUTTONS:Dictionary = new Dictionary(true);
		private var _data:Object = new Object();
		private var _selected:Boolean;
		private var _event:MouseEvent;
		private var _reference:uint;
		
		public function ButtonLite(groupName:String = null, hide:Boolean = false) {
			super.buttonMode = true;
			super.mouseChildren = false;
			super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			if (!BUTTONS[groupName]) {
				BUTTONS[groupName] = [];
			}
			BUTTONS[groupName].push(this);
			if (hide) this.out();
		}
		
		protected function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
			super.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
			super.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
			super.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
			this.initialize();
		}
		
		protected function onRemovedFromStage(event:Event):void {
			super.removeAllEventListener();
			this.finalize();
			BUTTONS = null;
		}
		
		protected function initialize():void {
			// to override
		}
		
		protected function finalize():void {
			// to override
		}
		
		public function click():void {
			// to override
		}

		public function active():void {
			this.over(); // to override
		}
		
		public function over():void {
			// to override
		}
		
		public function out():void {
			// to override
		}
		
		public function get event():MouseEvent {
			return this._event;
		}
		
		public function get selected():Boolean {
			return this._selected;
		}
		
		public function get data():Object {
			return this._data;
		}
		
		public function get reference():uint {
			return this._reference;
		}
		
		public function set reference(value:uint):void {
			this._reference = value;
		}
		
		public function set selected(value:Boolean):void {
			this._selected = value;
			this._selected ? this.active() : this.out();
		}
		
		private function onButtonMouseUp(event:MouseEvent):void {
			this._event = event;
			if (!this.selected) this.active();
		}
		
		private function onButtonMouseDown(event:MouseEvent):void {
			this._event = event;
			if (!this.selected) this.click();
		}
		
		private function onButtonMouseOver(event:MouseEvent):void {
			this._event = event;
			if (!this.selected) this.over();
		}
		
		private function onButtonMouseOut(event:MouseEvent):void {
			this._event = event;
			if (!this.selected) this.out();
		}

		public function getGroupByName(name:String):Array {
			return BUTTONS[name];
		}

		public function unselectAll(name:String):void {
			var group:Array = getGroupByName(name);
			for each (var item:ButtonLite in group) {
				if (item != this) {
					item.selected = false;
				}
			}
		}
		
		override public function toString():String {
			return '[ButtonLite ' + super.name + ']';
		}
	}
}