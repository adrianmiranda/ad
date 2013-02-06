package com.ad.common {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function createBitmapData(target:DisplayObject, width:Number = 0, height:Number = 0, transparent:Boolean = true, fillColor:uint = 0):BitmapData {
		var bounds:Rectangle = target.getBounds(target);
		var bitmap:BitmapData;
		var warning:String;
		width = bounds.x + (width || bounds.width);
		height = bounds.y + (height || bounds.height);
		try {
			bitmap = new BitmapData(width, height, transparent, fillColor);
			bitmap.draw(target);
		} catch (error:Error) {
			if (error.errorID == 2015) {
				warning  = ('Warning: ');
				warning += ('Increased memory usage. ');
				warning += ('Your movieclip has ' + Math.ceil(width + height)+'px. ');
				warning += ('Use the max of 5760px for createBitmapData method. ');
				warning += ('Or verify the target registration point.');
				trace(warning);
			} else {
				throw error;
			}
		}
		return bitmap;
	}
}