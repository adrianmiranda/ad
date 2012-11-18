package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function num(value:*):Number {
		value = Number(value);
		return((isNaN(value) || !isFinite(value)) ? 0 : value);
	}
}