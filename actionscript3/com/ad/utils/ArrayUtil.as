package com.ad.utils {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class ArrayUtil {
		
		public static function shuffle(instance:Array):Array {
			return instance.sort(function(...args):Number { return Math.round(Math.random() * 2) - 1; });
		}
		
		public static function switchElements(instance:Array, fromIndex:int, toIndex:int):Array {
			var elementA:Object = instance[fromIndex];
			var elementB:Object = instance[toIndex];
			instance.splice(fromIndex, 1, elementB);
			instance.splice(toIndex, 1, elementA);
			return instance;
		}
		
		public static function createUniqueCopy(instance:Array):Array {
			var result:Array = new Array();
			var index:uint = instance.length;
			var item:Object;
			while (index--) {
				item = instance[index];
				if (containsValue(result, item)) {
					continue;
				}
				result.push(item);
			}
			return result;
		}
		
		public static function concatUnique(...rest):Array {
			var result:Array = new Array();
			for each (var key:* in rest) {
				if (key is Array) {
					for each (var value:* in key) {
						if (result.indexOf(value) == -1) {
							result.push(value);
						}
					}
				}
			}
			return result;
		}
		
		public static function containsValue(instance:Array, value:Object):Boolean {
			return instance.indexOf(value) != -1;
		}
		
		public static function removeValue(instance:Array, value:Object):Array {
			if (containsValue(instance, value)) {
				return instance.splice(instance.indexOf(value), 1);
			}
			return instance;
		}
		
		public static function copy(instance:Array):Array {
			return instance.slice();
		}
		
		public static function equals(instanceA:Array, instanceB:Array):Boolean {
			instanceA = copy(instanceA).sort(Array.DESCENDING);
			instanceB = copy(instanceB).sort(Array.DESCENDING);
			return strictlyEquals(instanceA, instanceB);
		}
		
		public static function strictlyEquals(instanceA:Array, instanceB:Array):Boolean {
			if (instanceA.length != instanceB.length) {
				return false;
			}
			var index:uint = instanceA.length;
			while (index--) {
				if (instanceA[index] !== instanceB[index]) {
					return false;
				}
			}
			return true;
		}
		
		public static function distribute(instance:Array, length:uint = 0):Array {
			if (instance && instance.length > length) {
				return instance;
			}
			var result:Array = new Array(length);
			var coefficient:Number = (result.length - instance.length) / (instance.length - 1);
			var table:Number = 0;
			var index:int = -1;
			while (++index < instance.length) {
				result[Math.round(index ? (table = table + 1 + coefficient) : 0)] = instance[index];
			}
			return result;
		}
		
		public static function removeDuplicates(instance:Array):Array {
			return instance.filter(ArrayUtil.removeDuplicatesFilter);
		}
		
		private static function removeDuplicatesFilter(element:*, index:int, instance:Array):Boolean {
			return index != 0 ? instance.lastIndexOf(element, index - 1) == -1 : true;
		}
	}
}