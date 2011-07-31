package com.ad.common {
	
	public function between(value:Number, min:Number, max:Number):Number {
		return((value > max) ? max : (value < min ? min : value));
	}
}