package com.ad.common {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function createBitmapData(target:DisplayObject, width:Number = 0, height:Number = 0, transparent:Boolean = true, fillColor:uint = 0):BitmapData {
		var bounds:Rectangle = target.getBounds(target);
		var bitmap:BitmapData = new BitmapData(bounds.x + (width || bounds.width), bounds.y + (height || bounds.height), transparent, fillColor);
		bitmap.draw(target);
		return bitmap;
	}
}