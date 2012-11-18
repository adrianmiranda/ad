package com.ad.common {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function clamp(value:Number, min:Number, max:Number):Number {
		if (isNaN(value)) return NaN;
		if (isNaN(min)) min = value;
		if (isNaN(max)) max = value;
		return((value > max) ? max : (value < min ? min : value));
	}
}