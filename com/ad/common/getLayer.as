package com.ad.common {
	import com.ad.external.GetLayers;
	import com.ad.display.Layer;
	
	public function getLayer(id:String, at:String = 'default'):Layer {
		return GetLayers.fromFileID('layers_' + at)[id];
	}
}
