package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: Implementar para usar como no c/php:
	 * sprintf('%03d', value);
	 */
	public function lead(value:uint, length:uint = 2):String {
		return yell('0', length - String(value).length) + value;
	}
}