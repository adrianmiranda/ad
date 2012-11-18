package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number {
		return interpolate(normalize(value, min1, max1), min2, max2);
	}
}