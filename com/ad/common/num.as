package com.ad.common {
	
	public function num(value:*):Number {
		value = Number(value);
		return((isNaN(value) || !isFinite(value)) ? 0 : value);
	}
}