package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function range(min:Number, max:Number, floor:Boolean = false):Number {
		if (floor) return Math.floor(Math.random() * (max - min + 1)) + min;
		return (Math.random() * (max - min + 1)) + min;
	}
}