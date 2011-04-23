package com.ad.templates {
	import com.ad.display.Fairy;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name = 'click', type = 'flash.events.MouseEvent')]
	[Event(name = 'over', type = 'flash.events.MouseEvent')]
	[Event(name = 'out', type = 'flash.events.MouseEvent')]
	
	public class Button extends Fairy {
		private var _selected:Boolean;
		public var reference:int;
		
		public function Button(hide:Boolean = true) {
			super.buttonMode = true;
			super.mouseChildren = false;
			super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			if (hide) this.out(new MouseEvent(MouseEvent.MOUSE_OUT));
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
		}
		
		protected function initialize():void {
			// to override
		}
		
		protected function finalize():void {
			// to override
		}
		
		protected function click(event:MouseEvent):void {
			// to override
		}
		
		protected function over(event:MouseEvent):void {
			// to override
		}
		
		protected function out(event:MouseEvent):void {
			// to override
		}
		
		public function get selected():Boolean {
			return this._selected;
		}
		
		public function set selected(value:Boolean):void {
			this._selected = value;
			this._selected ? this.over(new MouseEvent(MouseEvent.MOUSE_OVER)) : this.out(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
		
		private function onButtonMouseUp(event:MouseEvent):void {
			if (!this.selected) this.over(event);
		}
		
		private function onButtonMouseDown(event:MouseEvent):void {
			if (!this.selected) this.click(event);
		}
		
		private function onButtonMouseOver(event:MouseEvent):void {
			if (!this.selected) this.over(event);
		}
		
		private function onButtonMouseOut(event:MouseEvent):void {
			if (!this.selected) this.out(event);
		}
		
		override public function toString():String {
			return '[Button ' + super.name + ']';
		}
	}
}