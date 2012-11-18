package com.ad.core {
	import com.ad.data.Parameters;
	import com.ad.data.Analytics;
	import com.ad.data.Layers;
	import com.ad.data.Texts;
	import com.ad.data.Links;
	import com.ad.proxy.nsapplication;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	use namespace nsapplication;
	public final class Application extends ApplicationFacade {
		
		public function Application(key:String = null) {
			super(key);
		}
		
		public static function getInstance(key:String = null):Application {
			if (!hasInstance(key)) instances[key] = new Application(key);
			return instances[key] as Application;
		}
		
		override public function startup(binding:DisplayObject = null):void {
			super.startup(binding);
			this.params(super.stage.loaderInfo.parameters);
		}
		
		public function layers(data:*, target:DisplayObjectContainer = null):Application {
			Layers.fromXML(super.getContent(data) || data, target || DisplayObjectContainer(super.binding), null);
			return this;
		}
		
		public function params(data:*, useOwnPrintf:Boolean = false):Application {
			Parameters.parse(super.getContent(data) || data, useOwnPrintf, null);
			return this;
		}
		
		public function tracks(data:*, useOwnPrintf:Boolean = false):Application {
			Analytics.parse(super.getContent(data) || data, useOwnPrintf, null);
			return this;
		}
		
		public function texts(data:*, useOwnPrintf:Boolean = false):Application {
			Texts.parse(super.getContent(data) || data, useOwnPrintf, null);
			return this;
		}
		
		public function links(data:*, useOwnPrintf:Boolean = false):Application {
			Links.parse(super.getContent(data) || data, useOwnPrintf, null);
			return this;
		}
	}
}