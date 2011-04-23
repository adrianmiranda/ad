package com.ad.common {
	
	public function force2Digits(value:Number):String {
		return (value < 10) ? '0' + String(value) : String(value);
	}
}