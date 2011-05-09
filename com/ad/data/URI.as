package com.ad.data {
		
	public final class URI {
		public var id:String;
		public var uri:String;
		public var source:String;
		
		public function URI(id:String = null, uri:String = null, source:String = null) {
			this.id = id;
			this.uri = this.recognizeAddress(uri);
			this.source = source;
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