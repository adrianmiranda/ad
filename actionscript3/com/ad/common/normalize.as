package com.ad.common {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function normalize(value:Number, minimum:Number, maximum:Number):Number {
		return (value - minimum) / (maximum - minimum);
	}
}