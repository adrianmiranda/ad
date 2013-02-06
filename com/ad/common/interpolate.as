package com.ad.common {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function interpolate(value:Number, minimum:Number, maximum:Number):Number {
		return minimum + (maximum - minimum) * value;
	}
}