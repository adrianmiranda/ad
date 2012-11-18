package com.ad.common {
	import com.ad.data.Parameters;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function $(id:String = null):* {
		if (id == null) return Parameters.shortcutTarget;
		return Parameters.shortcutTarget[id];
	}
}