package com.ad.utils {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class BranchUtils {
		
		public static function trimFirstLevel(value:String):String {
			return value.substring(value.indexOf('/') + 1, value.length);
		}
		
		public static function trimLastLevel(value:String):String {
			return value.substring(0, value.lastIndexOf('/'));
		}
		
		public static function trimSlash(value:String):String {
			return ltrimSlash(rtrimSlash(value));
		}
		
		public static function ltrimSlash(value:String):String {
			return validate(beginsWith(value, '/') ? value.substring(1, value.length) : value);
		}
		
		public static function rtrimSlash(value:String):String {
			return validate(endsWith(value, '/') ? value.substring(0, value.length - 1) : value);
		}
		
		public static function putSlash(value:String):String {
			return lputSlash(rputSlash(value));
		}
		
		public static function lputSlash(value:String):String {
			return value ? (beginsWith(value, '/') ? value : '/' + value) : '';
		}
		
		public static function rputSlash(value:String):String {
			return value ? (endsWith(value, '/') ? value : value + '/') : '';
		}
		
		public static function hasQueryString(value:String):Boolean {
			var index:int = value ? value.lastIndexOf('?') : -1;
			return (index != -1 && index < value.length && value.charCodeAt(index + 1) > 32);
		}
		
		public static function getQueryString(value:String, requireQuery:Boolean = true):String {
			value = hasQueryString(value) ? trimSlash(value.substr(value.lastIndexOf('?') + 1)) : '';
			return value ? requireQuery ? '?' + value : value : value;
		}
		
		public static function trimQueryString(value:String):String {
			return hasQueryString(value) ? trimSlash(value.substring(0, value.lastIndexOf('?'))) : value;
		}
		
		public static function getPathNames(value:String):Array {
			return cleanup(value).split('/');
		}
		
		public static function getLevel(value:String):uint {
			return getPathNames(value).length;
		}
		
		public static function cleanup(value:String):String {
			return trimSlash(validate(trimQueryString(value || '')));
		}
		
		public static function arrange(value:String, requireQueryString:Boolean = true):String {
			return putSlash(cleanup(value)) + (requireQueryString ? getQueryString(value) : '');
		}
		
		public static function validate(value:String):String {
			return value ? value.replace(/(\/){2,}/gi, '/') : value;
		}
		
		public static function isValid(value:String):Boolean {
			return value ? validate(value) == value : false;
		}
		
		public static function isValidWindow(value:String):Boolean {
			return value && (value == '_blank' || value == '_self' || value == '_top' || value == '_parent');
		}
		
		public static function remove(value:String, remove:String):String {
			return replace(value, remove, '');
		}
		
		public static function replace(value:String, replace:String, replaceWith:String):String {
			return value && replace && replaceWith ? value.split(replace).join(replaceWith) : value;
		}
		
		private static function beginsWith(input:String, prefix:String):Boolean {
			return input && prefix ? prefix == input.substring(0, prefix.length) : input;
		}
		
		private static function endsWith(input:String, suffix:String):Boolean {
			return input && suffix ? suffix == input.substring(input.length - suffix.length) : input;
		}
	}
}