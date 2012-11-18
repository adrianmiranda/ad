package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function bool(value:*):Boolean {
		if (value && value is String) value = value.toLowerCase();
		return value == 'true' || value == '1' || value == 'yes' || value == 'y' || value == 'sim' || value == 's';
	}
}