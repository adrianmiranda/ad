package com.ad.display {
	
	public class Rect extends Leprechaun {
		private var _color:uint;
		private var _width:Number;
		private var _height:Number;
		private var _alpha:Number;
		
		public function Rect(color:uint = 0x0, width:Number = 1, height:Number = 1, alpha:Number = 1.0) {
			this._color = color;
			this._width = width;
			this._height = height;
			this._alpha = alpha;
			this.draw();
		}
		
		private function draw():void {
			super.graphics.clear();
			super.graphics.beginFill(this._color, this._alpha);
			super.graphics.drawRect(0, 0, this._width, this._height);
			super.graphics.endFill();
		}
		
		override public function size(width:Number, height:Number):void {
			this._width = width;
			this._height = height;
			this.draw();
		}
		
		override public function set height(value:Number):void {
			this._height = value;
			this.draw();
		}
		
		override public function set width(value:Number):void {
			this._width = value;
			this.draw();
		}
		
		override public function toString():String {
			return '[Rect ' + super.name + ']';
		}
	}
}