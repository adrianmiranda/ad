package com.ad.external {
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	
	public final class JS {
		
		public static function gotoURL(url:*, window:String = '_self'):void {
			var request:URLRequest = url is String ? new URLRequest(url) : url;
			if (!available) {
				navigateToURL(request, window);
			} else {
				var userAgentValue:String = userAgent.toLowerCase();
				if (userAgentValue.indexOf('firefox') > -1 || (userAgentValue.indexOf('msie') > -1 && uint(userAgentValue.substr(userAgentValue.indexOf('msie') + 5, 3)) >= 7)) {
					call('window.open', request.url, window);
				} else {
					navigateToURL(request, window);
				}
			}
		}
		
		public static function popup(url:String, params:Object):void {
			var arguments:Array = new Array();
			var name:String;
			if (params) {
				name = params.name ? params.name : '';
				if (params.width) arguments.push('width=' + params.width);
				if (params.height) arguments.push('height=' + params.height);
				if (params.top) arguments.push('top=' + params.top);
				if (params.left) arguments.push('left=' + params.left);
				arguments.push('scrollbars=' + (params.scrollbars ? (params.scrollbars ? 'yes' : 'no') : 'no'));
				arguments.push('status=' + (params.status ? (params.status ? 'yes' : 'no') : 'no'));
				arguments.push('resizable=' + (params.resizable ? (params.resizable ? 'yes' : 'no') : 'no'));
				arguments.push('titlebar=' + (params.titlebar ? (params.titlebar ? 'yes' : 'no') : 'no'));
				arguments.push('menubar=' + (params.menubar ? (params.menubar ? 'yes' : 'no') : 'no'));
				arguments.push('location=' + (params.location ? (params.location ? 'yes' : 'no') : 'no'));
				if (params.toolbar) arguments.push('toolbar=' + (params.toolbar ? 'yes' : 'no'));
			}
			call('window.open', url, name, arguments.join(','));
		}
		
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
		
		public static function get hasConsole():Boolean {
			return available && (Security.sandboxType == 'remote' || Security.sandboxType == 'localTrusted');
		}
		
		public static function get marshallExceptions():Boolean {
			return ExternalInterface.marshallExceptions;
		}
		
		public static function get available():Boolean {
			return ExternalInterface.available;
		}
		
		public static function get objectID():String {
			return ExternalInterface.objectID;
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