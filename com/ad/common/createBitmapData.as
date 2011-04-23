package com.ad.common {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public function createBitmapData(target:DisplayObject):BitmapData {
		var bounds:Rectangle = target.getBounds(target);
		var bitmap:BitmapData = new BitmapData(bounds.x + bounds.width, bounds.y + bounds.height, true, 0);
		bitmap.draw(target);
		return bitmap;
	}
}