package com.ad.utils {
	import flash.display.DisplayObjectContainer;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.system.System;
	
	public final class Cleaner {
		
		public static function removeAllChildrensOf(displayObject:DisplayObjectContainer):void {
			var child:Object;
			var id:int = -1;
			while (++id < displayObject.numChildren) {
				child = displayObject.removeChild(displayObject.getChildAt(0));
				if (child is DisplayObjectContainer) {
					removeAllChildrensOf(child as DisplayObjectContainer);
				}
				child = null;
			}
		}
		
		public static function kill(displayObject:DisplayObjectContainer):void {
			removeAllChildrensOf(displayObject);
			if (displayObject.stage && displayObject.parent.contains(displayObject)) {
				displayObject.parent.removeChild(displayObject);
			}
		}
		
		public static function cleanupDictionary(dictionary:Dictionary):void {
			var key:String;
			for (key in dictionary) {
				delete dictionary[key];
			}
		}
		
		public static function cleanupObject(object:Object):void {
			var key:String;
			for (key in object) {
				delete object[key];
			}
		}
		
		public static function removeValueFromArray(array:Array, value:Object):void {
			var index:int = array.indexOf(value);
			if (index != -1) {
				array.splice(index, 1);
			}
		}
		
		public static function cleanupArray(array:Array):void {
			var id:int = -1;
			while (++id < array.length) {
				array.splice(id, 1);
			}
		}
		
		public static function removeValueFromVector(vector:Vector.<*>, value:*):void {
			var index:int = vector.indexOf(value);
			if (index != -1) {
				vector.splice(index, 1);
			}
		}
		
		public static function cleanupVector(vector:Vector.<*>):void {
			var id:int = -1;
			while (++id < vector.length) {
				vector.splice(id, 1);
			}
		}
		
		public static function gc():void {
			System.gc();
			System.gc();
			try {
				new LocalConnection().connect('gc');
				new LocalConnection().connect('gc');
			} catch (evt:Error) {
				// never implements, the Garbage Collector will
				// perform a full mark/sweep on the second call.
			}
		}
	}
}