package com.ad.common {
	
	public function getTrack(id:String, at:String = 'default'):Object {
		return GetValues.fromFileID('tracks_' + at)[id];
	}
}