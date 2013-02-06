package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function bool(value:*):Boolean {
		if (value && value is String) value = value.toLowerCase();
		return /^(true|1|yes|y|sim|s)$/ig.test(value);
	}
}