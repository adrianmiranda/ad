package com.ad.utils {
	import com.ad.events.URIEvent;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.events.Event;
	
	public final class URIManager extends URIComposite {
		
		public function URIManager() {
			if (self) throw new Error('Instantiation failed: Use URIManager.instance instead of new.');
			self = this as URIManager;
		}
		
		public static function get instance():URIManager {
			if (!self) self = new URIManager();
			return self as URIManager;
		}
		
		private function onURIChange(event:URIEvent):void {
			super.dispatchEvent(event.clone());
		}
	}
}