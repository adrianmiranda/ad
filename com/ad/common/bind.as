package com.ad.common {
	import com.ad.core.ApplicationRequest;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function bind(raw:String, core:String = null):String {
		var app:ApplicationRequest;
		if (core == null) app = ApplicationRequest.getInstance();
		else app = ApplicationRequest.getInstance(core);
		if (app && app.bind is Function) {
			return app.bind(raw);
		}
		return raw;
	}
}