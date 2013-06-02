package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function distance2D(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		var tx:Number = Math.abs(x1 - x2);
		var ty:Number = Math.abs(y1 - y2);
		return Math.pow(Math.pow(tx, 2) + Math.pow(ty, 2), 0.5);
	}
}