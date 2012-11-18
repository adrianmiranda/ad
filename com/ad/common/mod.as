package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function mod(index:Number, min:Number, max:Number):Number {
		var value:Number = index % max;
		return((value < min) ? (value + max) : value);
	}	
}