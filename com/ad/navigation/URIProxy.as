package com.ad.utils {
	import com.ad.events.EventControl;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public final class URIProxy extends EventControl {
		private var _onChange:Function;
		
		public function URIProxy() {
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onSWFAddressChange);
		}
		
		public function back():void {
			SWFAddress.back();
		}
		
		public function forward():void {
			SWFAddress.forward();
		}
		
		public function up():void {
			SWFAddress.up();
		}
		
		public function go(delta:int):void {
			SWFAddress.go(delta);
		}
		
		public function href(url:String, target:String = '_self'):void {
			SWFAddress.href(url, target);
		}
		
		public function popup(url:String, name:String = 'popup', options:String = '""', handler:String = ''):void {
			SWFAddress.popup(url, name, options, handler);
		}
		
		public function getBaseURL():String {
			return SWFAddress.getBaseURL();
		}
		
		public function getStrict():Boolean {
			return SWFAddress.getStrict();
		}
		
		public function setStrict(strict:Boolean):void {
			SWFAddress.setStrict(strict);
		}
		
		public function getHistory():Boolean {
			return SWFAddress.getHistory();
		}
		
		public function setHistory(history:Boolean):void {
			SWFAddress.setHistory(history);
		}
		
		public function getTracker():String {
			return SWFAddress.getTracker();
		}
		
		public function setTracker(tracker:String):void {
			SWFAddress.setTracker(tracker);
		}
		
		public function getTitle():String {
			return SWFAddress.getTitle();
		}
		
		public function setTitle(title:String):void {
			SWFAddress.setTitle(title);
		}
		
		public function getStatus():String {
			return SWFAddress.getStatus();
		}
		
		public function setStatus(status:String):void {
			SWFAddress.setStatus(status);
		}
		
		public function resetStatus():void {
			SWFAddress.resetStatus();
		}
		
		public function getValue():String {
			return SWFAddress.getValue();
		}
		
		public function setValue(value:String):void {
			SWFAddress.setValue(value);
		}
		
		public function getPath():String {
			return SWFAddress.getPath();
		}
		
		public function getPathNames():Array {
			return SWFAddress.getPathNames();
		}
		
		public function getQueryString():String {
			return SWFAddress.getQueryString();
		}
		
		public function getParameter(param:String):Object {
			return SWFAddress.getParameter(param);
		}
		
		public function getParameterNames():Array {
			return SWFAddress.getParameterNames();
		}
		
		private function onSWFAddressChange(event:SWFAddressEvent):void {
			if (this._onChange != null) {
				this._onChange();
			}
			super.dispatchEvent(new URIEvent(URIEvent.CHANGE));
		}
		
		override public function toString():String {
			return '[URIProxy]';
		}
	}
}