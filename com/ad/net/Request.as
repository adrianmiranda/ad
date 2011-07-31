package com.ad.net {
	import com.ad.common.applyCacheBuster;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.TimerEvent;
	//import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	
	public final class Request {
		private var _request:URLRequest;
		private var _data:Object;
		private var _weak:Boolean;
		private var _timeout:Number;
		private var _loader:URLLoader;
		private var _timerout:Timer;
		private var _onProgress:Function;
		private var _onResult:Function;
		private var _onFault:Function;
		private var _onTimeout:Function;
		private var _percentage:Number;
		private var _error:String;
		
		public function Request(url:String, data:Object = null, method:String = 'GET', timeout:Number = 30, weak:Boolean = true, noCache:Boolean = false) {
			if (url) {
				var variables:URLVariables = new URLVariables();
				if (data) {
					for (var key:String in data) {
						variables[key] = data[key];
					}
				}
				method = method.toUpperCase();
				url = noCache ? applyCacheBuster(url) : url;
				this._request = new URLRequest(url);
				this._request.method = method;
				this._request.data = variables;
				this._timeout = timeout || 0;
				this._weak = weak;
				var key:String;
				for (key in variables) {
					delete variables[key];
				}
				variables = null;
				key = null;
			}
		}
		
		public function send():void {
			if (this._request) {
				this.close(true);
				this._loader = new URLLoader(this._request);
				this._loader.addEventListener(Event.COMPLETE, this.onRequestResult, false, 0, this._weak);
				this._loader.addEventListener(ProgressEvent.PROGRESS, this.onRequestProgress, false, 0, this._weak);
				this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault, false, 0, this._weak);
				this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault, false, 0, this._weak);
				this._timerout = new Timer(this._timeout * 1000, 0);
				this._timerout.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut, false, 0, this._weak);
				this._timerout.start();
			} else {
				this.toString();
			}
		}
		
		public function close(flush:Boolean = false):void {
			if (this._request && this._loader) {
				this._timerout.stop();
				this._timerout.reset();
				this._timerout.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut);
				this._loader.removeEventListener(Event.COMPLETE, this.onRequestResult);
				this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onRequestProgress);
				this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault);
				this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault);
				try {
					this._loader.close();
				} catch(event:Error) {
					trace(this.toString(), event.message);
				}
				if (flush) {
					var key:String;
					for (key in this._data) {
						delete this._data[key];
					}
					key = null;
					this._data = null;
					this._loader = null;
					this._timerout = null;
					this._percentage = NaN;
					this._error = null;
				}
			} else {
				this.toString();
			}
		}
		
		private function onRequestResult(event:Event):void {
			this._data = this._loader.data;
			if (this._onResult != null) {
				this._onResult();
			}
			if (this._weak) {
				this.close(true);
			}
		}
		
		private function onRequestProgress(event:ProgressEvent):void {
			this._percentage = int(event.bytesLoaded / event.bytesTotal);
			if (this._onProgress != null) {
				this._onProgress();
			}
		}
		
		private function onRequestFault(event:ErrorEvent):void {
			this._error = event.text;
			if (this._onFault != null) {
				this._onFault();
			}
			if (this._weak) {
				this.close(true);
			}
		}
		
		private function onRequestTimedOut(event:TimerEvent):void {
			this._error = 'Request timed out.';
			if (this._onTimeout != null) {
				this._onTimeout();
			} else {
				this._onFault();
			}
			if (this._weak) {
				this.close(true);
			}
		}
		
		public function set onProgress(closure:Function):void {
			this._onProgress = closure;
		}
		
		public function set onResult(closure:Function):void {
			this._onResult = closure;
		}
		
		public function set onFault(closure:Function):void {
			this._onFault = closure;
		}
		
		public function set onTimeout(closure:Function):void {
			this._onTimeout = closure;
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
		
		public function set weak(value:Boolean):void {
			this._weak = value;
		}
		
		public function get weak():Boolean {
			return this._weak;
		}
		
		public function debug():void {
			if (this._request) {
				trace('> Request ---------------------------------------------------');
				trace('- url:', this._request.url);
				trace('- method:', this._request.method);
				trace('- variables:');
				var key:String;
				for (key in this._request.data) {
					trace('\t>', key + ':', this._request.data[key]);
				}
				key = null;
				trace('-------------------------------------------------------------');
			}
		}
		
		public function toString():String {
			return '[Request ' + (this._request ? this._request.url : '???') + ']';
		}
	}
}