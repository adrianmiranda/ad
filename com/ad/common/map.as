package com.ad.common {
	
	public function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number {
		return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
	}
}