package com.ad.common {
	
	public function parseNumber(value:*):Number {
		value = Number(value);
		return(isNaN(value) ? 0 : value);
	}
}