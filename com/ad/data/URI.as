package com.ad.data {
		
	public final class URI {
		public var id:String;
		public var uri:String;
		public var source:String;
		
		public function URI(id:String = null, uri:String = null, source:String = null) {
			this.id = id;
			this.uri = uri;
			this.source = source;
		}
		
		public function toString():String {
			return '[URI ' + this.id + ']';
		}
	}
}