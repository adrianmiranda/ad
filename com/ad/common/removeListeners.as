package com.ad.common {
	import flash.events.EventDispatcher;
	
	public function removeListeners(objects:Array, type:String, func:Function):void {
		var id:int = objects.length;
		while (id--) {
			if (objects[id] is EventDispatcher) {
				if (objects[id].hasEventListener(type)) {
					objects[id].removeEventListener(type, func);
				}
			}
		}
	}
}