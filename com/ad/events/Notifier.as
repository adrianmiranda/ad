package com.ad.events  {
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	final public class Notifier {
		protected static var notification:Note;
		protected static var dispatcher:EventControl;
		
		public static function notify(notificationName:String, target:Object, data:* = null):Boolean {
			notification = new Note(notificationName, target, data);
			return dispatchEvent(notification);
		}

		public static function listen(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			if (!dispatcher) dispatcher = new EventControl();
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			if (!dispatcher) return;
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function removeAllListener():void {
			if (!dispatcher) return;
			dispatcher.removeAllEventListener();
		}
		
		public static function dispatchEvent(event:Event):Boolean {
			if (!dispatcher) return false;
			return dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean {
			if (!dispatcher) return false;
			return dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean {
			if (!dispatcher) return false;
			return dispatcher.willTrigger(type);
		}
		
		public static function get data():* {
			if (!notification) return new Object();
			return notification.data;
		}
	}
}