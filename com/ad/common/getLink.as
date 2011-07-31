package com.ad.common {
	import com.ad.external.GetValues;

	public function getLink(id:String, key:String = 'value', at:String = 'default'):String {
		var value:* = GetValues.fromFileID('links_' + at)[id];
		if (value is String) return value;
		else return value[key] || id + ':{??? ' + key + '}';
	}
}