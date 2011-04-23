package com.ad.common {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public function createBitmapData(target:DisplayObject):BitmapData {
		var rect:Rectangle = target.getBounds(target);
		var bitmap:BitmapData = new BitmapData(rect.x + rect.width, rect.y + rect.height, true, 0);
		bitmap.draw(target);
		return bitmap;
	}
}