package com.ad.common {
	import com.ad.navigation.SectionLiteManager;
	
	public function gotoURI(uri:String, at:String = ''):void {
		SectionLiteManager.instance(at).goto(uri);
	}
}