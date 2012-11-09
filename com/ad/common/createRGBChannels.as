package com.ad.common {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian Miranda
	 */
	public function createRGBChannels(bmp:Bitmap):Array {
		var r:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0xFF000000);
		var g:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0xFF000000);
		var b:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0xFF000000);
		r.copyChannel(bmp.bitmapData, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0), BitmapDataChannel.RED, BitmapDataChannel.RED);
		g.copyChannel(bmp.bitmapData, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
		b.copyChannel(bmp.bitmapData, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
		return [new BitmapData(bmp.width, bmp.height, true, 0xFF000000), r, g, b];
	}
}