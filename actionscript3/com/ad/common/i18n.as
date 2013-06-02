package com.ad.common {
	import com.ad.data.Texts;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function i18n(id:String = null):* {
		if (id == null) return Texts.shortcutTarget;
		return Texts.shortcutTarget[id];
	}
}