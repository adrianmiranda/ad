package com.ad.common {
	import com.ad.external.GetValues;

	public function getLink(id:String, at:String = 'default'):String {
		return GetValues.fromFileID('links_' + at)[id];
	}
}