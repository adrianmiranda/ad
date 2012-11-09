package com.ad.utils {
	import __AS3__.vec.Vector;
	
	final public class VectorUtil {
		
		public static function isVector(vector:*):Boolean {
			try {
				return Object(vector).constructor.toString().indexOf('class Vector') > -1;
			} catch (error:Error) {
				// never implement
			}
			return false;
		}
		
		public static function typeOf(vector:*):String {
			var result:String;
			if (isVector(vector)) {
				result = Object(vector).constructor.toString();
				result = result.substring(result.indexOf('<') + 1, result.indexOf('>'))
			}
			return result;
		}
		
		public static function toArray(vector:*):Array {
			var result:Array = [];
			for (var id:int = 0, total:int = vector.length; id < total; id++) {
				result[id] = vector[id];
			} 
			return result;
		}
		
		public static function sortOn(vector:*, fieldName:Object, options:Object = null):Array {
			return toArray(vector).sortOn(fieldName, options);
		}
		
		public static function removeItem(vector:*, item:*):uint {
			var id:int = vector.indexOf(item);
			var index:uint = 0;
			var fixed:Boolean = vector.fixed;
			vector.fixed = false;
			while (id != -1) {
				vector.splice(id, 1);
				id = vector.indexOf(item, id);
				index++;
			}
			vector.fixed = fixed;
			return index;
		}
	}
}