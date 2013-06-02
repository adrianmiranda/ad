package com.ad.utils {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class DictionaryUtil {
		public static function getKeys(dictionary:Dictionary):Array {
			return ObjectUtils.getKeys(dictionary);
		}
		
		public static function containsValue(dictionary:Dictionary, value:Object):Boolean {
			var result:Boolean = false;
			for each (var key:* in dictionary) {
				if (key === value) {
					result = true;
					break;
				}
			}
			return result;
		}
	}
}