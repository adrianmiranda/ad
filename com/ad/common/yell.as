package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function yell(char:String, length:int, prefix:String = ''):String {
		return length ? yell(char, length - 1, prefix) + char : prefix;
	}
}