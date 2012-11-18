package com.ad.utils {
	import __AS3__.vec.Vector;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.system.System;
	import flash.display.Loader;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class Cleaner {
		
		public static function removeChildrenOf(target:DisplayObjectContainer):void {
			if (!target) return;
			var child:DisplayObject;
			while (target.numChildren > 0) {
				child = target.getChildAt(0);
				if (child) {
					if (child is Loader) {
						continue;
					}
					target.removeChild(child);
					if (!child is Loader) {
						if (child is DisplayObjectContainer) {
							removeChildrenOf(child as DisplayObjectContainer);
						}
					}
				}
				child = null;
			}
		}
		
		public static function kill(target:DisplayObjectContainer):void {
			if (!target) return;
			removeChildrenOf(target);
			if (target.stage && target.parent && target.parent.contains(target)) {
				target.parent.removeChild(target);
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