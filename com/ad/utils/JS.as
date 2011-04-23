package com.ad.utils {
	import flash.system.Security;
	import flash.external.ExternalInterface;
	
	public final class JS {
		
		public static function addCallback(jsFunction:String, asFunction:Function):void {
			if (available) {
				ExternalInterface.addCallback(jsFunction, asFunction);
			}
		}
		
		public static function call(jsFunction:String, ...rest:Array):* {
			if (available) {
				return ExternalInterface.call.apply(null, [jsFunction].concat(rest));
			}
			return '';
		}
		
		public static function get available():Boolean {
			return ExternalInterface.available;
		}
		
		public static function get hasConsole():Boolean {
			return available && (Security.sandboxType == 'remote' || Security.sandboxType == 'localTrusted');
		}
		
		public static function get userAgent():String {
			return call('navigator.userAgent.toString');
		}
		
		public static function get protocol():String {
			return call('window.location.protocol.toString');
		}
		
		public static function get host():String {
			return call('window.location.host.toString');
		}
		
		public static function get hostname():String {
			return call('window.location.hostname.toString');
		}
		
		public static function get pathname():String {
			return call('window.location.pathname.toString');
		}
		
		public static function get href():String {
			return call('window.location.href.toString');
		}
		
		public static function get port():String {
			return call('window.location.port.toString');
		}
		
		public static function get hash():String {
			return call('window.location.hash.toString');
		}
		
		public static function get search():String {
			return call('window.location.search.toString');
		}
		
		public static function alert(...rest:Array):void {
			call.apply(null, ['alert'].concat(rest));
		}
		
		public static function log(...rest:Array):void {
			call.apply(null, ['console.log'].concat(rest));
		}
		
		public static function debug(...rest:Array):void {
			call.apply(null, ['console.debug'].concat(rest));
		}
		
		public static function info(...rest:Array):void {
			call.apply(null, ['console.info'].concat(rest));
		}
		
		public static function warn(...rest:Array):void {
			call.apply(null, ['console.warn'].concat(rest));
		}
		
		public static function error(...rest:Array):void {
			call.apply(null, ['console.error'].concat(rest));
		}
		
		public static function dir(...rest:Array):void {
			call.apply(null, ['console.dir'].concat(rest));
		}
		
		public static function time(...rest:Array):void {
			call.apply(null, ['console.time'].concat(rest));
		}
		
		public static function timeEnd(...rest:Array):void {
			call.apply(null, ['console.timeEnd'].concat(rest));
		}
	}
}