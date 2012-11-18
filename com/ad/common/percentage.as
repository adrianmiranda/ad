package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function percentage(value:Number, maximum:Number):Number {
		return num((value / maximum) * 100);
	}
}