package com.ad.common {
	
	public function randomRange(min:Number, max:Number, floor:Boolean = false):Number {
		if (floor) return Math.floor(Math.random() * (max - min + 1)) + min;
		return (Math.random() * (max - min + 1)) + min;
	}
}