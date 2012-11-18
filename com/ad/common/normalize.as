package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function normalize(value:Number, minimum:Number, maximum:Number):Number {
		return (value - minimum) / (maximum - minimum);
	}
}