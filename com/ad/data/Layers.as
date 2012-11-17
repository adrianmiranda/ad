package com.ad.data {
	import com.ad.common.bool;
	import com.ad.proxy.nsdisplay;
	import com.ad.display.Layer;
	//import com.ad.utils.StringUtil;
	//import com.ad.utils.Display;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	use namespace nsdisplay;
	final public class Layers extends Proxy {
		public static var shortcutTarget:Layers = new Layers();
		public var holder:DisplayObjectContainer;
		public var data:Object;
		
		public function Layers() {
			this.data = new Object();
		}
		
		override flash_proxy function callProperty(name:*, ...rest):* {
			throw new Error('There is no method called: \'' + name + '\' in [Layers].');
			return null;
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean {
			return delete this.data[name];
		}
		
		override flash_proxy function setProperty(name:*, propertyValue:*):void {
			this.data[name] = propertyValue;
		}
		
		override flash_proxy function getProperty(name:*):* {
			if (this.data[name] == null) {
				throw new Error('Layer: ' + name + ' doesn\'t exist');
			}
			return this.data[name];
		}
		
		override flash_proxy function hasProperty(name:*):Boolean {
			return this.data.hasOwnProperty(name);
		}
		
		public static function fromXML(xml:*, container:DisplayObjectContainer, instance:Layers = null):void {
			var node:XML;
			var id:String;
			var layer:DisplayObjectContainer;
			var layers:Layers = instance || Layers.shortcutTarget;
			layers.holder = container;
			for each(node in xml.layer) {
				id = String(node.@id || node.id);
				if (id) {
					layer = new Layer();
					layer.name = id;
					(layer as Layer).setNode(node);
					(layer as Layer).locked = bool(node.@locked);
					(layer as Layer).showRegistrationPoint = bool(node.@showRegistrationPoint);
					layer.x = Number(node.@x || node.x || '0'); // temporary
					layer.y = Number(node.@y || node.y || '0'); // temporary
					layer.alpha = 1;
					layers.holder.addChild(layer);
					layers.data[layer.name] = layer;
					layers.arrange(layer as Layer);
				}
				if (node.hasOwnProperty('layer')) {
					Layers.fromXML(node, layer, instance);
				}
			}
		}
		
		public function removeAllLayers(instance:Layers = null):void {
			var layers:Layers = instance || Layers.shortcutTarget;
			var layer:DisplayObjectContainer;
			var key:String;
			for (key in layers.data) {
				layer = layers.data[key];
				(layer as Layer).die();
				delete layers.data[key];
			}
			layers.data = null;
		}
		
		private function arrange(layer:Layer):void {
			var state:uint;
			var node:XML = layer.getNode();
			var params:Object = new Object();
			/*var align:String = StringUtil.trim(node.@align).toLowerCase();
			if (align)
			{
				if (align.search('top') != -1) state += Display.TOP;
				if (align.search('center') != -1) state += Display.CENTER;
				if (align.search('bottom') != -1) state += Display.BOTTOM;
				if (align.search('middle') != -1) state += Display.MIDDLE;
				if (align.search('right') != -1) state += Display.RIGHT;
				if (align.search('left') != -1) state += Display.LEFT;
				if (align.search('none') != -1) state += Display.NONE;
				if (align.length == 2) {
					if (align.search('tl') != -1) {
						state += Display.TOP;
						state += Display.LEFT;
					}
					if (align.search('tr') != -1) {
						state += Display.TOP;
						state += Display.RIGHT;
					}
					if (align.search('cl') != -1) {
						state += Display.CENTER;
						state += Display.LEFT;
					}
					if (align.search('cr') != -1) {
						state += Display.CENTER;
						state += Display.RIGHT;
					}
					if (align.search('bl') != -1) {
						state += Display.BOTTOM;
						state += Display.LEFT;
					}
					if (align.search('br') != -1) {
						state += Display.BOTTOM;
						state += Display.RIGHT;
					}
				}
				if (StringUtil.trim(node.@marginLeft)) params.marginLeft = Number(StringUtil.trim(node.@marginLeft));
				if (StringUtil.trim(node.@marginRight)) params.marginRight = Number(StringUtil.trim(node.@marginRight));
				if (StringUtil.trim(node.@marginTop)) params.marginTop = Number(StringUtil.trim(node.@marginTop));
				if (StringUtil.trim(node.@marginBottom)) params.marginBottom = Number(StringUtil.trim(node.@marginBottom));
			}*/
		}
	}
}