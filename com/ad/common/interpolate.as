package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function interpolate(value:Number, minimum:Number, maximum:Number):Number {
		return minimum + (maximum - minimum) * value;
	}
}