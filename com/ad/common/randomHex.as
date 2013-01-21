package com.ad.common {
	import com.ad.data.Links;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function get randomHex():uint {
		return uint('0x'+Math.floor(Math.random() * 16777215).toString(16));
	}
}