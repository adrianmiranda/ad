package com.ad.utils {
	import com.ad.events.URIEvent;
	import com.ad.events.EventControl;
	import com.ad.interfaces.IURIProxy;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public final class URIProxy extends EventControl implements IURIProxy {
		protected static var self:IURIProxy;
		private var _onChange:Function;
		private var _onChangeParams:Array;
		
		public function URIProxy() {
			if (self) throw new Error('Instantiation failed: Use URIProxy.instance instead of new.');
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onSWFAddressChange);
			self = this;
		}
		
		public static function get instance():IURIProxy {
			if (self == null) self = new URIProxy();
			return self;
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
		
		public function set onChange(closure:Function):void {
			this._onChange = closure;
		}
		
		public function set onChangeParams(value:Array):void {
			this._onChangeParams = value;
		}
		
		private function onSWFAddressChange(event:SWFAddressEvent):void {
			if (this._onChange != null) {
				this._onChange.apply(null, this._onChangeParams);
			}
			super.dispatchEvent(new URIEvent(URIEvent.CHANGE));
		}
		
		protected function onURIChange(event:URIEvent):void {
			// to override
		}
		
		override public function toString():String {
			return '[URIProxy]';
		}
	}
}