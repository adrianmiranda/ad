package com.ad.net {
	import com.ad.common.applyCacheBuster;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
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
		private var _request:URLRequest;
		private var _data:Object;
		private var _weak:Boolean;
		private var _loader:URLLoader;
		private var _timeout:Timer;
		private var _onProgress:Function;
		private var _onResult:Function;
		private var _onFault:Function;
		private var _onTimeout:Function;
		private var _percentage:Number;
		
		public function Request(url:String, data:Object = null, method:String = 'GET', timeout:Number = 30, noCache:Boolean = false, weak:Boolean = true) {
			this._weak = weak;
			if (url == null) return;
			var variables:URLVariables = new URLVariables();
			var key:String;
			if (data) {
				for (key in data) {
					variables[key] = data[key];
				}
			}
			url = noCache ? applyCacheBuster(url) : url;
			this._timeout = new Timer((timeout || 0) * 1000, 1);
			this._request = new URLRequest(url);
			this._request.method = URLRequestMethod[method.toUpperCase()];
			this._request.data = variables;
			key = null;
			for (key in variables) {
				delete variables[key];
			}
			variables = null;
			key = null;
		}
		
		public function send():void {
			if (this._request) {
				this.close(true);
				this._loader = new URLLoader(this._request);
				this._loader.addEventListener(Event.COMPLETE, this.onRequestResult, false, 0, this._weak);
				this._loader.addEventListener(ProgressEvent.PROGRESS, this.onRequestProgress, false, 0, this._weak);
				this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault, false, 0, this._weak);
				this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault, false, 0, this._weak);
				this._timeout.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut, false, 0, this._weak);
				this._timeout.start();
			} else {
				this.debug();
			}
		}
		
		public function close(flush:Boolean = false):void {
			if (this._request && this._loader) {
				this._timeout.stop();
				this._timeout.reset();
				this._timeout.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRequestTimedOut);
				this._loader.removeEventListener(Event.COMPLETE, this.onRequestResult);
				this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onRequestProgress);
				this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRequestFault);
				this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onRequestFault);
				try {
					this._loader.close();
				} catch(event:Error) {
					// no yet implements
				}
				if (flush) {
					var key:String;
					for (key in this._data) {
						delete this._data[key];
					}
					key = null;
					this._data = null;
					this._loader = null;
					this._percentage = NaN;
				}
			} else {
				this.debug();
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
			if (this._onFault != null) {
				this._onFault();
			}
			if (this._weak) {
				this.close(true);
			}
		}
		
		private function onRequestTimedOut(event:TimerEvent):void {
			this.close(true);
			if (this._onTimeout != null) {
				this._onTimeout();
			} else {
				this._onFault();
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
			trace(this.toString());
		}
		
		public function toString():String {
			var output:String = new String();
			output += '\n> Request ------------------------------------------------------------------\n';
			output += '- url: ' + String(this._request ? this._request.url : '??? url') + '\n';
			output += '- method: ' + String(this._request ? this._request.method : '??? method') + '\n';
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