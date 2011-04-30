package com.ad.utils {
	import flash.display.DisplayObjectContainer;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.system.System;
	
	public final class Cleaner {
		
		public static function removeAllChildrenOf(target:DisplayObjectContainer):void {
			var child:Object;
			var id:int = -1;
			while (++id < target.numChildren) {
				child = target.removeChildAt(0);
				if (child is DisplayObjectContainer) {
					removeAllChildrensOf(child as DisplayObjectContainer);
				}
				child = null;
			}
		}
		
		public static function kill(target:DisplayObjectContainer):void {
			removeAllChildrensOf(target);
			if (target.stage && target.parent.contains(target)) {
				target.parent.removeChild(target);
			}
		}
		
		public static function cleanupDictionary(target:Dictionary):void {
			var key:String;
			for (key in target) {
				delete target[key];
			}
		}
		
		public static function cleanupObject(target:Object):void {
			var key:String;
			for (key in target) {
				delete target[key];
			}
		}
		
		public static function removeValueFromArray(target:Array, value:Object):void {
			var index:int = target.indexOf(value);
			if (index != -1) {
				target.splice(index, 1);
			}
		}
		
		public static function cleanupArray(target:Array):void {
			var id:int = -1;
			while (++id < target.length) {
				target.splice(id, 1);
			}
		}
		
		public static function removeValueFromVector(target:Vector.<*>, value:*):void {
			var index:int = target.indexOf(value);
			if (index != -1) {
				target.splice(index, 1);
			}
		}
		
		public static function cleanupVector(target:Vector.<*>):void {
			var id:int = -1;
			while (++id < target.length) {
				target.splice(id, 1);
			}
		}
		
		public static function gc():void {
			System.gc();
			System.gc();
			try {
				new LocalConnection().connect('gc');
				new LocalConnection().connect('gc');
			} catch (event:Error) {
				// never implements, the Garbage Collector will
				// perform a full mark/sweep on the second call.
			}
		}
	}
}