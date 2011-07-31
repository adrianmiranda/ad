package com.ad.common {
	import com.ad.external.GetValues;

	public function getText(id:String, at:String = 'default'):String {
		var value:* = GetValues.fromFileID('texts_' + at)[id];
		if (value is String) return value;
		else return value['value'] || id + ':{??? ' + key + '}';
	}
}