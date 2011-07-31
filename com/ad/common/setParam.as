package com.ad.common {
	import com.ad.external.GetValues;
	
	public function setParam(id:String, value:*, at:String = 'default'):* {
		GetValues.fromFileID('parameters_' + at)[id] = value;
		return value;
	}
}