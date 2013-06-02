package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function percentage(value:Number, maximum:Number):Number {
		return num((value / maximum) * 100);
	}
}