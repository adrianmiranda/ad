package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function num(value:*):Number {
		value = Number(value);
		return((isNaN(value) || !isFinite(value)) ? 0 : value);
	}
}