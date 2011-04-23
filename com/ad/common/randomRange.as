package com.ad.common {
	
	public function randomRange(min:Number, max:Number, floor:Boolean = false):Number {
		var result:Number;
		if (floor) {
			result = Math.floor(Math.random() * (max - min + 1)) + min;
		} else {
			result = (Math.random() * (max - min + 1)) + min;
		}
		return result;
	}
}