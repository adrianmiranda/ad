package com.ad.interfaces {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IEventControl extends IEventDispatcher {
		function removeAllEventListener():void;
	}
}