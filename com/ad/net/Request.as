package com.ad.net {
	import com.ad.common.formatTime;
	import com.ad.common.applyCacheBuster;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	
	public final class Request {
		private var _url:String;
		private var _method:String;
		private var _request:URLRequest;
		private var _data:Object;
		private var _weak:Boolean;
		private var _loader:URLLoader;
		private var _timeout:Timer;
		private var _delay:Number;
		private var _vars:Object;
		private var _tries:int;
		private var _percentage:Number;
		
		public function Request(url:String, data:Object = null, method:String = 'GET', timeout:uint = 30, noCache:Boolean = false, weak:Boolean = true) {
			this._url = url;
			this._weak = weak;
			this._method = method;
			this._delay = (timeout || 0) * 1000;
			if (this._url == null) return;
			var variables:URLVariables = new URLVariables();
			if (data) {
				var key:String;
				for (key in data) variables[key] = data[key];
			}
			this._vars = {};
			this._url = noCache ? applyCacheBuster(this._url) : this._url;
			this._timeout = new Timer(this._delay, 1);
			this._request = new URLRequest(this._url);
			this._request.data = variables;
			if (!URLRequestMethod[method.toUpperCase()]) {
				this._method = 'The method \'' + method + '\' doesn\'t exists on URLRequestMethod. Replaced by \'GET\'.';
				this.log();
			}
			this._request.method = URLRequestMethod[method.toUpperCase()] || 'GET';
			this._method = null;
			for (key in variables) delete variables[key];
			variables = null;
			key = null;
		}
		
		public function send(url:String = null, tries:uint = 3):void {
			if (!this._request) return;
			this.close(true);
			if (url) {
				if (this._tries >= tries) return;
				if (this._request.url != url) this._tries = 0;
				this._request.url = url;
				this._weak = false;
				this._tries++;
			}
			this._loader = new URLLoader(this._request);
			this._loader.addEventListener(Event.COMPLETE, this.onRequestResult, false, 0, this._weak);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault, false, 0, this._weak);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault, false, 0, this._weak);
			this._timeout.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut, false, 0, this._weak);
			this._timeout.start();
		}
		
		public function close(flush:Boolean = false):void {
			if (this._request && this._loader) {
				this._timeout.reset();
				this._timeout.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut);
				this._loader.removeEventListener(Event.COMPLETE, this.onRequestResult);
				this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault);
				this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault);
				try { this._loader.close(); } catch(event:Error) { /* no yet implements */ }
				if (flush) {
					var key:String;
					for (key in this._data) delete this._data[key];
					key = null;
					this._url = null;
					this._method = null;
					this._data = null;
					this._loader = null;
					this._percentage = NaN;
				}
			}
		}
		
		public function dispose():void {
			this.close(true);
			if (this._request) {
				var key:String;
				for (key in this._vars) delete this._vars[key];
				key = null;
				this._vars = null;
				this._timeout = null;
				this._request = null;
			}
		}
		
		private function onRequestResult(event:Event):void {
			this._data = this._loader.data;
			if (this._vars.onResult != null) {
				this._vars.onResult.apply(null, this._vars.onResultParams);
			}
			if (this._weak) this.dispose();
		}
		
		private function onRequestFault(event:ErrorEvent):void {
			if (this._vars.onFault != null) {
				this._vars.onFault.apply(null, this._vars.onFaultParams);
			}
			if (this._weak) this.close(true);
		}
		
		private function onRequestTimedOut(event:TimerEvent):void {
			this.close(true);
			if (this._vars.onTimeout != null) {
				this._vars.onTimeout.apply(null, this._vars.onTimeoutParams);
			} else {
				this._vars.onFault.apply(null, this._vars.onFaultParams);
			}
		}
		
		public function set onResult(closure:Function):void {
			if (this._vars) this._vars.onResult = closure;
		}
		
		public function set onFault(closure:Function):void {
			if (this._vars) this._vars.onFault = closure;
		}
		
		public function set onTimeout(closure:Function):void {
			if (this._vars) this._vars.onTimeout = closure;
		}
		
		public function set onResultParams(parameters:Array):void {
			if (this._vars) this._vars.onResultParams = parameters;
		}
		
		public function set onFaultParams(parameters:Array):void {
			if (this._vars) this._vars.onFaultParams = parameters;
		}
		
		public function set onTimeoutParams(parameters:Array):void {
			if (this._vars) this._vars.onTimeoutParams = parameters;
		}
		
		public function get raw():String {
			return String(this._data);
		}
		
		public function get xml():XML {
			if (this._data) return new XML(this._data);
			else return null;
		}
		
		public function get json():Object {
			var json:Object;
			if (this._data) {
				try {
					json = JSON.decode(String(this._data));
				} catch(event:Error) {
					json = new Object();
				}
			}
			return json;
		}
		
		public function get weak():Boolean {
			return this._weak;
		}
		
		public function log():void {
			trace(this.toString());
		}
		
		public function toString():String {
			var output:String = new String();
			output += '\n> Request ------------------------------------------------------------------\n';
			output += '- url: ' + String(this._request ? this._request.url : '??? ' + this._url) + '\n';
			output += '- method: ' + String(this._request ? this._request.method : '??? ' + this._method) + '\n';
			output += '- timeout: ' + formatTime((this._timeout ? this._timeout.delay : this._delay) / 1000, 'mm:ss') + '\n';
			output += '- weak: ' + this._weak + '\n';
			if (this._request) {
				var key:String;
				var variables:String = new String();
				for (key in this._request.data) {
					variables += '\t> ' + key + ': ' + this._request.data[key] + '\n';
				}
				if (variables) {
					output += '\t- variables:\n' + variables + '\n';
				}
			}
			variables = null;
			key = null;
			output += '----------------------------------------------------------------------------';
			return output;
		}
	}
}