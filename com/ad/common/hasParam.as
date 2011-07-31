package com.ad.common {
	import com.ad.external.GetValues;

	public function hasParam(id:String, at:String = 'default'):* {
		return getParam(id, at) != '??? ' + id;
	}
}