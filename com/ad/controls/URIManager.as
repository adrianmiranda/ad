package com.ad.utils {
	import com.ad.events.URIEvent;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.events.Event;
	
	public final class URIManager extends URIComposite {
		
		public function URIManager() {
			// no yet implement
		}
		
		private function onURIChange(event:URIEvent):void {
			super.dispatchEvent(event.clone());
			super.dispatchEvent(new URIEvent(URIEvent.CHANGE));
		}
	}
}