package com.ad.data {
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: 
	 */
	public final class Model {
		
		public static function parameters(data:*, useOwnPrintf:Boolean = false):Parameters {
			return Parameters.parse(data, useOwnPrintf, null);
		}
		
		public static function tracks(data:*, useOwnPrintf:Boolean = false):Analytics {
			return Analytics.parse(data, useOwnPrintf, null);
		}
		
		public static function links(data:*, useOwnPrintf:Boolean = false):Links {
			return Links.parse(data, useOwnPrintf, null);
		}
		
		public static function texts(data:*, useOwnPrintf:Boolean = false):Texts {
			return Texts.parse(data, useOwnPrintf, null);
		}
		
		public static function layers(data:XML, target:DisplayObjectContainer):void {
			Layers.fromXML(data, target, null);
		}
	}
}