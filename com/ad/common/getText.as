package com.ad.common {
	import com.ad.external.GetValues;

	public function getText(id:String, at:String = 'default'):String {
		return GetValues.fromFileID('texts_' + at)[id];
	}
}