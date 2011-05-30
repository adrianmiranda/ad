package com.ad.api {
	import com.ad.utils.Rope;
	import com.ad.external.JS;
	import com.ad.common.getTrack;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public final class Tracking {
		
		public static function tag(id:String):void {
			var data:Object = getTrack(id);
			if (data is String) {
				trace(data);
				return;
			} else {
				var jsFunction:String = Rope.trim(data.jsFunction);
				var code:String = Rope.trim(data.code);
				var tag:String = Rope.trim(data.tag);
				if (code && tag) {
					adWords(code, tag);
				} else if (code) {
					eyeBlaster(code);
				} else if (tag) {
					ga(tag, jsFunction);
				} else {
					// no yet implement
				}
			}
		}
		
		public static function ga(tag:String, jsFunction:String = null):void {
			JS.call(jsFunction || 'pageTracker._trackPageview', tag);
		}
		
		public static function eyeBlaster(code:String):void {
			if (JS.available) {
				var eyeBlasterRandom:Number = Math.random() * 1000000;
				var activityParams:String = escape('Activityid=' + code + '&f=1');
				var url:String = 'HTTP://bs.serving-sys.com/BurstingPipe/activity3.swf?ebAS=bs.serving-sys.com&activityParams=' + activityParams + '&rnd=' + eyeBlasterRandom;
				var request:URLRequest = new URLRequest(url);
				var loader:Loader = new Loader();
				try {
					loader.load(request);
				} catch (event:Error) {
					trace('[Tracking eyeBlaster]', event.message);
				}
			}
		}
		
		public static function adWords(code:String, tag:String):void {
			if (JS.available) {
				var url:String = 'https://www.googleadservices.com/pagead/conversion/' + code + '/?label=' + tag + '&amp;guid=ON&amp;script=0';
				var request:URLRequest = new URLRequest(url);
				var loader:Loader = new Loader();
				try {
					loader.load(request);
				} catch (event:Error) {
					trace('[Tracking adWords]', event.message);
				}
			}
		}
		
		public static function predicta():void {
			// no yet implement
		}
	}
}