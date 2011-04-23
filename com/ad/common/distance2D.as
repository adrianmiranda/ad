package com.ad.common {
	
	public function distance2D(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		var horizontal:Number = Math.abs(x1 - x2);
		var vertical:Number = Math.abs(y1 - y2);
		return Math.pow(Math.pow(horizontal, 2) + Math.pow(vertical, 2), 0.5);
	}	
}