package com.ad.data {
		
	public final class URI {
		public var id:String;
		private var _uri:String;
		public var label:String; // optional
		public var source:String;
		public var window:String;
		public var layer:String; // optional
		public var menu:Boolean;
		public var contextMenu:Boolean;
		public var isUriDefault:Boolean;
		public var isUriError:Boolean;
		
		public function URI(id:String = null, label:String = null, uri:String = null, source:String = null, layer:String = null, window:String = null, menu:Boolean = true, contextMenu:Boolean = false, isUriDefault:Boolean = false, isUriError:Boolean = false) {
			this.id = id;
			this.uri = uri;
			this.label = label;
			this.source = source;
			this.window = window;
			this.layer = layer;
			this.menu = menu;
			this.contextMenu = contextMenu;
			this.isUriDefault = isUriDefault;
			this.isUriError = isUriError;
		}
		
		public function get uri():String {
			return this._uri;
		}
		
		public function set uri(value:String):void {
			this._uri = recognizeAddress(value);
		}
		
		public function get level():uint {
			return (this.uri) ? this.uri.split('/').length : 0;
		}
		
		private function recognizeAddress(value:String):String {
			if (!value) return null;
			var index:Number = value.indexOf('?');
			var hasQuery:Boolean = ((index != -1) && (index < value.length));
			var query:String = (hasQuery) ? value.substr(index) : '';
			if (hasQuery) value = value.substring(0, index);
			if (value.charAt(value.length - 1) != '/') {
				value = value + '/';
			}
			if (value.charAt(0) != '/') {
				value = '/' + value;
			}
			return value + query;
		}
		
		public function toString():String {
			return '[URI ' + this.id + ']';
		}
	}
}