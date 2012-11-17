package com.ad.interfaces {
	import flash.events.IEventDispatcher;
	
	public interface IEventControl extends IEventDispatcher {
		function removeAllEventListener():void;
	}
}