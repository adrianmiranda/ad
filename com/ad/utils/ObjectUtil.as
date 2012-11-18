package com.ad.utils {
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.Dictionary;
	import flash.utils.ByteArray;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * @see http://labs.influxis.com/wp-content/uploads/huw_column1.pdf
	 */
	final public class ObjectUtil {
		
		public static function isObject(instance:*):Boolean {
			try {
				return instance.constructor === Object;
			} catch (error:Error) {
				// never implement
			}
			return false;
		}
		
		public static function hasComplexContent(instance:*):Boolean {
			return ObjectUtil.isObject(instance) || instance is Array || VectorUtil.isVector(instance) || instance is Date;
		}
		
		public static function getProperties(object:Object):Array
		{
			var result:Array = [];
			for each (var key:Object in object)
			{
				result.push(key);
			}
			return result;
		}
		
		public static function getNumProperties(object:Object):uint
		{
			return getProperties(object).length;
		}
		
		public static function getKeys(object:Object):Array
		{
			var result:Array = [];
			for (var key:* in object)
			{
				result.push(key);
			}
			return result;
		}
		
		public static function getNumKeys(object:Object):uint
		{
			return getKeys(object).length;
		}
		
		public static function toDictionary(instance:Object):Dictionary
		{
			var result:Dictionary = new Dictionary();
			for each (var key:* in getKeys(instance))
			{
				result[key] = instance[key];
			}
			return result;
		}
		
		public static function decode(text:String, reviver:Function = null):Object
		{
			//return JSON.parse(text, reviver);
			return JSON.decode(text);
		}
		
		public static function encode(value:Object, replacer:* = null, space:* = null):String
		{
			//return JSON.stringify(value, replacer, space);
			return JSON.encode(value);
		}
		
		public static function resolvePropertyChain(chain:String, targetInstance:Object):*
		{
			var propertyNames:Array = chain.split('.');
			var field:String = String(propertyNames.pop());
			var propName:String;
			for each (propName in propertyNames)
			{
				targetInstance = targetInstance[propName];
			}
			return targetInstance[field];
		}
		
		public static function merge(objectA:Object, objectB:Object):Object
		{
			var result:Object, property:String;
			if (objectB)
			{
				result = new Object();
				for (property in objectB)
				{
					result[property] = objectB[property];
				}
				for (property in objectA)
				{
					result[property] = objectA[property];
				}
			}
			return result || objectA;
		}
		
		public static function censor(object:Object, text:String):String {
			var expression:String = '';
			for (var key:Object in object) {
				expression += expression == '' ? '' : '|'; // add an 'or' for multiple search words
				expression += '\\b' + object[key] + '\\b'; // only whole words
			}
			return text.replace(new RegExp(expression, 'gi'), '----');
		}
		
		public static function clone(object:Object):*
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(object);
			byteArray.position = 0;
			return byteArray.readObject();
		}
	}
}