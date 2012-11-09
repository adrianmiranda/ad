package com.ad.display {
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	
	public class Fig extends Shape {
		
		public function Fig() {
			super();
		}
		
		public function move(x:Number, y:Number):void {
			super.x = Math.round(x);
			super.y = Math.round(y);
		}
		
		public function size(width:Number, height:Number):void {
			super.width = width;
			super.height = height;
		}
		
		public function set scale(value:Number):void {
			super.scaleX = super.scaleY = value;
		}
		
		override public function toString():String {
			return '[Fig ' + super.name + ']';
		}
	}
}