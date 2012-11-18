package com.ad.interfaces {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IEventControl extends IEventDispatcher {
		function removeAllEventListener():void;
	}
}