package com.ad.utils
{
	import com.ad.errors.IllegalArgumentError;
	import com.ad.errors.IllegalStateError;
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class Assert {
		public static function isTrue(expression:Boolean, message:String = ''):void {
			if (!expression) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this expression must be true';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		public static function notAbstract(instance:Object, abstractClass:Class, message:String = ''):void {
			var instanceName:String = getQualifiedClassName(instance);
			var abstractName:String = getQualifiedClassName(abstractClass);
			if (instanceName == abstractName) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - instance is an instance of an abstract class';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		public static function notNull(object:Object, message:String = ''):void {
			if (object == null) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this argument is required; it must not null';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		public static function instanceOf(object:*, type:Class, message:String = ''):void {
			if (!(object is type)) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this argument is not of type "' + type + '"';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		/*public static function subclassOf(caste:Class, parentClass:Class, message:String = ''):void {
			if (!ClassUtils.isSubclassOf(caste, parentClass)) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this argument is not a subclass of "' + parentClass + '"';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		public static function implementationOf(object:*, interfaze:Class, message:String = ''):void {
			if (!ClassUtils.isImplementationOf(ClassUtils.forInstance(object), interfaze)) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this argument does not implement the interface "' + interfaze + '"';
				}
				throw new IllegalArgumentError(message);
			}
		}*/
		
		public static function state(expression:Boolean, message:String = ''):void {
			if (!expression) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this state invariant must be true';
				}
				throw new IllegalStateError(message);
			}
		}
		
		/*public static function hasText(string:String, message:String = ''):void {
			if (StringUtils.isBlank(string)) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this String argument must have text; it must not be <code>null</code>, empty, or blank';
				}
				throw new IllegalArgumentError(message);
			}
		}*/
		
		public static function dictionaryKeysOfType(dictionary:Dictionary, type:Class, message:String = ''):void {
			for (var key:Object in dictionary) {
				if (!(key is type)) {
					if (message == null || message.length == 0) {
						message = '[Assertion failed] - this Dictionary argument must have keys of type "' + type + '"';
					}
					throw new IllegalArgumentError(message);
				}
			}
		}
		
		public static function arrayContains(array:Array, item:*, message:String = ''):void {
			if (array.indexOf(item) == -1) {
				if (message == null || message.length == 0) {
					message = '[Assertion failed] - this Array argument does not contain the item "' + item + '"';
				}
				throw new IllegalArgumentError(message);
			}
		}
		
		public static function arrayItemsOfType(array:Array, type:Class, message:String = ''):void {
			for each (var item:* in array) {
				if (!(item is type)) {
					if (message == null || message.length == 0) {
						message = '[Assertion failed] - this Array must have items of type "' + type + '"';
					}
					throw new IllegalArgumentError(message);
				}
			}
		}
	}
}