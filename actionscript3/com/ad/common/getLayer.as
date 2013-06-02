package com.ad.common {
	import com.ad.data.Layers;
	import com.ad.display.Layer;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function getLayer(id:String = null):* {
		if (id == null) return Layers.shortcutTarget;
		return Layers.shortcutTarget[id];
	}
}