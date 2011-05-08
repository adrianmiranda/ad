package com.ad.utils {
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public final class Tracking {
		
		public static function ga(tag:String):void {
			JS.call('pageTracker._trackPageview', tag);
		}
		
		public static function eyeBlaster(code:String):void {
			if (JS.available) {
				var eyeBlasterRandom:Number = Math.random() * 1000000;
				var activityParams:String = escape('ActivityID=' + code + '&f=1');
				var url:String = 'HTTP://bs.serving-sys.com/BurstingPipe/activity3.swf?ebAS=bs.serving-sys.com&activityParams=' + activityParams + '&rnd=' + eyeBlasterRandom;
				var request:URLRequest = new URLRequest(url);
				var loader:Loader = new Loader(request);
			}
		}
		
		public static function adWords(ID:String, label:String):void {
			if (JS.available) {
				var url:String = 'https://www.googleadservices.com/pagead/conversion/' + ID + '/?label=' + label + '&amp;guid=ON&amp;script=0';
				var request:URLRequest = new URLRequest(url);
				var loadAdwords:Loader = new Loader(request);
			}
		}
	}
}