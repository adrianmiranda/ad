package com.ad.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	dynamic public class DynamicBitmap extends Bitmap {
		public function DynamicBitmap(bitmapData:BitmapData = null) {
			super(bitmapData);
		}
		
		override public function toString():String {
			return '[DynamicBitmap ' + super.name + ']';
		}
	}
}