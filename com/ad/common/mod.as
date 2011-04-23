package com.ad.common {
	
	public function mod(index:Number, min:Number, max:Number):Number {
		var value:Number = index % max;
		return((value < min) ? (value + max) : value);
	}	
}