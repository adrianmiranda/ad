package com.ad.common {
	import com.ad.data.Links;
	
	public function _(id:String = null):* {
		if (id == null) return Links.shortcutTarget;
		return Links.shortcutTarget[id];
	}
}