package com.ad.common {
	import com.ad.data.Links;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function get randomHex():uint {
		return uint('0x'+Math.floor(Math.random() * 16777215).toString(16));
	}
}