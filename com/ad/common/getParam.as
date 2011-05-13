package com.ad.common {
	import com.ad.external.GetValues;

	public function getParam(id:String, at:String = 'default'):String {
		return GetValues.fromFileID('parameters_' + at)[id];
	}
}