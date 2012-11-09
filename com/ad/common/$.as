package com.ad.common {
	import com.ad.data.Parameters;
	
	public function $(id:String = null):* {
		if (id == null) return Parameters.shortcutTarget;
		return Parameters.shortcutTarget[id];
	}
}