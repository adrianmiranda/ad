package com.ad.common {
	
	/**
	 * TODO: Implementar para usar como no c:
	 * sprintf('%03d', value);
	 */
	public function sprintf(value:uint, length:uint = 2):String {
		return yell('0', length - String(value).length) + value;
	}
}