package com.ad.common {
	import com.ad.data.Texts;
	
	public function i18n(id:String = null):* {
		if (id == null) return Texts.shortcutTarget;
		return Texts.shortcutTarget[id];
	}
}