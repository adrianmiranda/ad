package com.ad.utils {
	import com.ad.events.EventControl;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public final class URIProxy extends EventControl {
		
		public function URIProxy() {
			// no yet implement
		}
		
		public static function back():void {
			SWFAddress.back();
		}
		
		public static function forward():void {
			SWFAddress.forward();
		}
		
		public static function up():void {
			SWFAddress.up();
		}
		
		public static function go(delta:int):void {
			SWFAddress.go(delta);
		}
		
		public static function href(url:String, target:String = '_self'):void {
			SWFAddress.href(url, target);
		}
		
		public static function popup(url:String, name:String='popup', options:String='""', handler:String=''):void {
			SWFAddress.popup(url, name, options, handler);
		}
		
		public static function getBaseURL():String {
			return SWFAddress.getBaseURL();
		}
		
		public static function getStrict():Boolean {
			return SWFAddress.getStrict();
		}
		
		public static function setStrict(strict:Boolean):void {
			SWFAddress.setStrict(strict);
		}
		
		public static function getHistory():Boolean {
			return SWFAddress.getHistory();
		}
		
		public static function setHistory(history:Boolean):void {
			SWFAddress.setHistory(history);
		}
		
		public static function getTracker():String {
			return SWFAddress.getTracker();
		}
		
		public static function setTracker(tracker:String):void {
			SWFAddress.setTracker(tracker);
		}
		
		public static function getTitle():String {
			return SWFAddress.getTitle();
		}
		
		public static function setTitle(title:String):void {
			SWFAddress.setTitle(title);
		}
		
		public static function getStatus():String {
			return SWFAddress.getStatus();
		}
		
		public static function setStatus(status:String):void {
			SWFAddress.setStatus(status);
		}
		
		public static function resetStatus():void {
			SWFAddress.resetStatus();
		}
		
		public static function getValue():String {
			return SWFAddress.getValue();
		}
		
		public static function setValue(value:String):void {
			SWFAddress.setValue(value);
		}
		
		public static function getPath():String {
			return SWFAddress.getPath();
		}
		
		public static function getPathNames():Array {
			return SWFAddress.getPathNames();
		}
		
		public static function getQueryString():String {
			return SWFAddress.getQueryString();
		}
		
		public static function getParameter(param:String):Object {
			return SWFAddress.getParameter(param);
		}
		
		public static function getParameterNames():Array {
			return SWFAddress.getParameterNames();
		}
		
		override public function toString():String {
			return '[URIProxy]';
		}
	}
}