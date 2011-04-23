package com.ad.common {
	
	public function applyCacheBuster(url:String):String {
		if (url) {
			var cachebuster:String = 'cacheBusterID=' + new Date().getTime().toString();
			if (url.indexOf('?') > -1) return url + '&' + cachebuster;
			return url + '?' + cachebuster;
		}
		return url;
	}
}