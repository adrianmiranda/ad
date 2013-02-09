package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.interfaces.ISection;
	import com.ad.net.Request;
	import com.ad.utils.Binding;
	import com.ad.errors.ADError;
	import com.ad.proxy.nsapplication;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	use namespace nsapplication;
	public class ApplicationRequest extends ApplicationCore {
		private var _binding:DisplayObject;
		private var _request:Request;
		private var _header:Header;
		private var _xml:XML;
		
		public function ApplicationRequest(key:String = null) {
			super(key);
		}
		
		public static function getInstance(key:String = null):ApplicationRequest {
			if (!hasInstance(key)) instances[key] = new ApplicationRequest(key);
			return instances[key] as ApplicationRequest;
		}
		
		public function fromXML(urlOrXML:*, data:Object = null, method:String = 'GET', timeout:int = 80):void {
			if (urlOrXML is String) {
				this._request = new Request(urlOrXML, data, method, timeout);
				this._request.onResult = this.onRequestResult;
				this._request.onFault = this.onRequestFault;
				delete super.vars.source;
			}
			else if (urlOrXML is XML) {
				super.vars.source = urlOrXML;
				if (this._request) {
					this._request.close(true);
					this._request = null;
				}
			}
			else {
				var error:String = '*Invalid Views XML* ApplicationRequest ';
				throw new ADError(error + 'fromXML method should receive a data type String or XML');
			}
		}
		
		public function startup(binding:DisplayObject = null):void {
			this._binding = binding;
			// @usage: '{@bind}string'['bind']();
			String.prototype.bind = function():String {
				return Binding.bind(this, this._binding);
			}
			if (this._request) {
				this._request.send(this.bind(this._request.url));
			}
			else if (super.vars.source) {
				this.onRequestResult();
			}
		}
		
		protected function onRequestResult():void {
			this._xml = this._request ? this._request.xml : super.vars.source;
			this._header = new Header(this._xml, this._binding);
			if (super.vars.onParsed) {
				super.vars.onParsed.apply(null, super.vars.onParsedParams);
			}
		}
		
		protected function onRequestFault():void {
			if (super.vars.onFault) {
				super.vars.onFault.apply(null, super.vars.onFaultParams);
			} else {
				trace('ERROR: ' + this._request.url + ' failed to load.');
			}
		}
		
		public function set onParsed(closure:Function):void {
			super.vars.onParsed = closure;
		}
		
		public function set onParsedParams(value:Array):void {
			super.vars.onParsedParams = value;
		}
		
		public function set onFault(closure:Function):void {
			super.vars.onFault = closure;
		}
		
		public function set onFaultParams(value:Array):void {
			super.vars.onFaultParams = value;
		}
		
		protected function get parsed():Boolean {
			return this._request ? this._request.rawData != null : false;
		}
		
		public function get base():DisplayObject {
			var base:ISection;
			if (this.header) {
				base = new this.header.views.root.caste();
				base.name = this.header.views.root.className;
				base.apiKey = super.apiKey;
			}
			return DisplayObject(base);
		}
		
		public function get binding():DisplayObject {
			return this._binding;
		}
		
		public function get header():Header {
			return this._header;
		}
		
		public function get xml():XML {
			return this._xml;
		}
		
		public function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}
		
		override public function dispose(flush:Boolean = false):void {
			if (this._request) {
				this._request.close(true);
				this._request = null;
			}
			if (this._header) {
				this._header.dispose();
				this._header = null;
			}
			if (flush) {
				this._binding = null;
				this._xml = null;
			}
			super.dispose(flush);
		}
		
		override public function toString():String {
			return '[ApplicationRequest ' + super.apiKey + ']';
		}
	}
}