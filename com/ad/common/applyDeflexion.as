package com.ad.common {
	import com.ad.utils.JS;
	
	public function applyDeflexion(localPath:String = '../', browserPath:String = ''):String {
		var protocol:String, hostname:String, port:String, pathname:String, filepath:String;
		protocol = JS.protocol;
		hostname = JS.hostname;
		port = JS.port;
		pathname = JS.pathname;
		port = (port) ? ':' + port : '';
		filepath = (protocol && protocol.substr(0, 4) != 'http') ? browserPath : localPath;
		return(protocol && hostname && pathname ? protocol + '//' + hostname + port + pathname + browserPath : filepath);
	}
}