package com.ad.data {
	import com.ad.common.num;
	import com.ad.common.bool;
	import com.ad.proxy.nsdisplay;
	import com.ad.display.Layer;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 > TODO: Arrangement and registration point movement.
	 */
	use namespace nsdisplay;
	public final class Layers extends Proxy {
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
					layer.x = num(node.@x || node.x || '0'); // @temporary
					layer.y = num(node.@y || node.y || '0'); // @temporary
					layer.visible = node.@visible == undefined ? true : bool(node.@visible);
					layer.alpha = 1;
					layers.holder.addChild(layer);
					layers.data[layer.name] = layer;
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
	}
}