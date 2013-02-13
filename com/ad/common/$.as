package com.ad.common {
	import com.ad.data.Parameters;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function $(id:String = null, param:* = null):* {
		if (id == null) return Parameters.shortcutTarget;
		if (id is String && param != null) {
			Parameters.shortcutTarget[id] = param;
		}
		return Parameters.shortcutTarget[id];
	}
}