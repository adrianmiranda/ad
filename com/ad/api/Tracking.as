package com.ad.api {
	import com.ad.utils.Rope;
	import com.ad.external.JS;
	import com.ad.common.getTrack;
	//import com.google.analytics.AnalyticsTracker;
	//import com.google.analytics.GATracker;
	
	import flash.display.Stage;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public final class Tracking {
		//private static var tracker:AnalyticsTracker;
		
		public function Tracking() {
			throw new Error('Instantiation failed: Tracking is a static class');
		}
		
		public static function initialize(stage:Stage):void {
			//tracker = new GATracker(stage, 'UA-22082745-1', 'AS3', false);
		}
		
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
					gaTracker(code, tag, jsFunction);
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
		
		public static function gaTracker(tag:String, code:String, jsFunction:String = null):void {
			if (JS.available) {
				var gaTrackerRandom:int = Math.floor(Math.random() * 10000000));
				var request:URLRequest = new URLRequest('http://ia.nspmotion.com//ptag/?pt=' + code + '&value=[number]&cvalues=[key|value,key|value]&r=' + gaTrackerRandom;
				var loader:Loader = new Loader();
				try {
					loader.load(request);
					ga(tag, jsFunction);
					//tracker.trackPageview(tag);
				} catch (event:Error) {
					trace('[Tracking googleAnalytics]', event.message);
				}
			}
		}
		
		public static function ga(tag:String, jsFunction:String = null):void {
			JS.call(jsFunction || 'pageTracker._trackPageview', tag);
		}
		
		public static function eyeBlaster(code:String):void {
			if (JS.available) {
				var eyeBlasterRandom:int = Math.floor(Math.random() * 10000000);
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
			// no yet implemented
		}
	}
}