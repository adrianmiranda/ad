package com.ad.common {
	import com.ad.external.GetValues;
	
	public function setParam(id:String, value:*, at:String = 'default'):void {
		GetValues.fromFileID('parameters_' + at)[id] = value;
	}
}