package com.ad.common {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * simulate double click handler with mouseChildren true
	 */
	public function addDoubleClick(target:DisplayObject, listener:Function = null, delay:Number = 0.15):Function {
		var clicks:uint, timeout:uint, timeup:uint;
		target.addEventListener(MouseEvent.MOUSE_DOWN, onmousedown, false, 0, true);
		function onmousedown(event:MouseEvent):void {
			if (!clicks) {
				target.addEventListener(MouseEvent.MOUSE_UP, onmouseup, false, 0, true);
				(function aid():void {
					while (clicks) {--clicks};
					clearTimeout(timeout);
					timeout = setTimeout(aid, delay * 1000);
				}());
			}
			if (++clicks >= 2) {
				if (listener !== null) {
					listener.call(null, event);
				}
				clearTimeout(timeout);
				clicks = 0;
			}
		}
		function onmouseup(event:MouseEvent):void {
			target.removeEventListener(MouseEvent.MOUSE_UP, onmouseup);
			clearTimeout(timeup);
			timeup = setTimeout(function():void {
				clearTimeout(timeout);
				clicks = 0;
			}, delay * 1000);
		}
		return onmousedown;
	}
}