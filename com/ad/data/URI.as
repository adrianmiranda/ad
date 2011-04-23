package com.ad.data {
		
	public final class URI {
		public var id:String;
		public var deeplink:String;
		public var source:String;
		
		public function URI(id:String = null, deeplink:String = null, source:String = null) {
			this.id = id;
			this.deeplink = deeplink;
			this.source = source;
		}
		
		public function toString():String {
			return '[URI ' + this.id + ']';
		}
	}
}