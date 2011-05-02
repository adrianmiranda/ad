package com.ad.net {
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class Request {
		private var _request:URLRequest;
		private var _loader:URLLoader;
		private var _onProgress:Function;
		private var _onResult:Function;
		private var _onFault:Function;
		private var _onTimeout:Function;
		private var _timeout:Timer;
		private var _data:Object;
		private var _weak:Boolean;
		private var _percentage:Number;
		private var _error:String;
		
		public function Request(url:String, data:Object = null, method:String = 'GET', weak:Boolean = true, timeout:int = 15) {
			var variables:URLVariables = new URLVariables();
			if (data) {
				for (var key:String in data) {
					variables[key] = data[key];
				}
			}
			this._timeout = new Timer(timeout * 1000, 0);
			this._request = new URLRequest(url);
			this._request.method = method;
			this._request.data = variables;
			this._weak = weak;
		}
		
		public function load():void {
			this._loader = new URLLoader(this._request);
			this._loader.addEventListener(Event.COMPLETE, this.onRequestResult, false, 0, this._weak);
			this._loader.addEventListener(ProgressEvent.PROGRESS, this.onRequestProgress, false, 0, this._weak);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault, false, 0, this._weak);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault, false, 0, this._weak);
			this._timeout.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut, false, 0, this._weak);
			this._timeout.start();
		}
		
		public function close(flush:Boolean = false):void {
			if (this._loader) {
				this._timeout.stop();
				this._timeout.reset();
				this._loader.removeEventListener(Event.COMPLETE, this.onRequestResult);
				this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onRequestProgress);
				this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault);
				this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault);
				this._timeout.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut);
				try {
					this._loader.close();
				} catch(event:Error) {
					trace(this.toString(), event.message);
				}
				if (flush) {
					this._loader = null;
				}
			}
		}
		
		public function onRequestResult(event:Event):void {
			this._data = this._loader.data;
			if (this._onResult != null) {
				this._onResult();
			}
			if (this._weak) {
				this.close(true);
			}
		}

		public function onRequestProgress(event:ProgressEvent):void {
			this._percentage = int(event.bytesLoaded / event.bytesTotal);
			if (this._onProgress != null) {
				this._onProgress();
			}
		}

		public function onRequestFault(event:ErrorEvent):void {
			this._error = event.text;
			if (this._onFault != null) {
				this._onFault();
			}
			if (this._weak) {
				this.close(true);
			}
		}
		
		public function onRequestTimedOut(event:TimerEvent):void {
			this._error = 'Request timed out.';
			if (this._onTimeout != null) {
				this._onTimeout();
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
		
		public function get rawData():Object {
			return this._data;
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
				trace('******** TRACEVARS ******');
				trace('url:', this._request.url);
				trace('method:', this._request.method);
				trace('variables:');
				for (var key:String in this._request.data) {
					trace('   -', key, this._request.data[key]);
				}
				trace('******** #!# ******');
			}
		}
		
		public function toString():String {
			return '[Request ' + (this._request) ? this._request.url : '???' + ']';
		}
	}
}