package com.ad.common {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function yell(char:String, length:int, prefix:String = ''):String {
		return length > 0 ? yell(char, length - 1, prefix) + char : prefix;
	}
}