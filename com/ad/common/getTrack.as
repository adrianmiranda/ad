package com.ad.common {
	import com.ad.external.GetValues;
	
	public function getTrack(id:String, at:String = 'default'):Object {
		return GetValues.fromFileID('tracks_' + at)[id];
	}
}
