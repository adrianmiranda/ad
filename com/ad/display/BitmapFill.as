package com.ad.display {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BitmapFill extends Sprite {
		private var _width:int;
		private var _heigth:int;
		private var _bmpData:BitmapData;
		private var _holder:Sprite;
		
		public function BitmapFill(bmpData:BitmapData, width:int = 1, heigth:int = 1) {
			this._width = width;
			this._heigth = heigth;
			this._bmpData = bmpData;
			this._holder = new Sprite();
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
			this.draw();
		}
		
		private function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			this._holder.graphics.clear();
			super.removeChild(this._holder);
			this._bmpData = null;
			this._holder = null;
			this._width = 0;
			this._heigth = 0;
		}
		
		private function draw():void {
			this._holder.graphics.clear();
			this._holder.graphics.beginBitmapFill(this._bmpData, null, true);
			this._holder.graphics.drawRect(0, 0, this._width, this._heigth);
			this._holder.graphics.endFill();
		}
		
		public function bitmapResize(width:int, height:int):void {
			this._width = width;
			this._heigth = heigth;
			this.draw();
		}
		
		override public function toString():String {
			return '[BitmapFill ' + super.name + ']';
		}
	}
}