package com.ad.common {
	import com.ad.api.Tracking;
	
	public function setTrack(id:String):void {
		Tracking.call(id);
	}
}