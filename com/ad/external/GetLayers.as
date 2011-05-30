package com.ad.external {
	import com.ad.common.parseBoolean;
	import com.ad.display.Layer;
	import com.ad.proxy.nsdisplay;
	import com.ad.utils.Display;
	import com.ad.utils.Rope;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary;
	import flash.display.Sprite;
	
	use namespace nsdisplay;
	public class GetLayers extends Proxy {
		private static var instanceCollection:Array = new Array();
		private static var holder:Sprite;
		private var _layerDictionary:Dictionary;
		private var _multitonKey:String;
		
		public function GetLayers(key:String) {
			if (instanceCollection[key]) throw new Error('Instantiation failed: Use GetLayers.fromFileID(key) instead of new.');
			instanceCollection[this._multitonKey] = this;
			this._layerDictionary = new Dictionary(true);
		}
		
		public static function appendLayers(value:XML, container:Sprite, at:String = 'default'):void {
			holder = container;
			GetLayers.fromFileID('layers_' + at).layersFromXML(value, container);
		}
		
		public static function removeLayers(at:String = 'default'):void {
			GetLayers.fromFileID('layers_' + at).removeAllLayers();
		}
		
		public static function fromFileID(key:String = ''):GetLayers {
			key = key ? key : 'default';
			if (!instanceCollection[key]) instanceCollection[key] = new GetLayers(key);
			return instanceCollection[key];
		}
		
		override flash_proxy function callProperty(name:*, ...rest):* {
			throw new Error('There is no method called: \'' + name + '\' in GetLayers[' + this._multitonKey + '].');
			return null;
		}
		
		override flash_proxy function setProperty(name:*, propertyValue:*):void {
			this._layerDictionary[name] = propertyValue;
		}
		
		override flash_proxy function getProperty(name:*):* {
			return getLayer(name);
		}
		
		public function removeAllLayers():void {
			var layer:Sprite;
			var key:String;
			for (key in this._layerDictionary) {
				layer = this._layerDictionary[key];
				(layer as Layer).die();
				delete this._layerDictionary[key];
			}
			this._layerDictionary = null;
		}
		
		public function getLayer(name:String):* {
			if (!this._layerDictionary[name]) {
				throw new Error('Layer \'' + name + '\' doesn\'t exist.');
			}
			return this._layerDictionary[name];
		}
		
		public function getHolder():Sprite {
			return holder;
		}
		
		private function layersFromXML(xml:XML, container:Sprite):void {
			var node:XML;
			var id:String;
			var layer:Sprite;
			for each(node in xml.layer) {
				id = String(node.@id || node.id);
				if (id) {
					layer = new Layer();
					layer.name = id;
					(layer as Layer).setNode(node);
					(layer as Layer).locked = parseBoolean(node.@locked);
					(layer as Layer).showRegistrationPoint = parseBoolean(node.@showRegistrationPoint);
					layer.x = Number(node.@x || node.x || '0'); // temporary
					layer.y = Number(node.@y || node.y || '0'); // temporary
					container.addChild(layer);
					this._layerDictionary[layer.name] = layer;
					this.arrange(layer as Layer);
				}
				if (node.hasOwnProperty('layer')) {
					this.layersFromXML(node, layer);
				}
			}
		}
		
		private function arrange(layer:Layer):void {
			var state:uint;
			var node:XML = layer.getNode();
			var align:String = Rope.trim(node.@align).toLowerCase();
			var params:Object = new Object();
			if (align) {
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
				if (Rope.trim(node.@marginLeft)) params.marginLeft = Number(Rope.trim(node.@marginLeft));
				if (Rope.trim(node.@marginRight)) params.marginRight = Number(Rope.trim(node.@marginRight));
				if (Rope.trim(node.@marginTop)) params.marginTop = Number(Rope.trim(node.@marginTop));
				if (Rope.trim(node.@marginBottom)) params.marginBottom = Number(Rope.trim(node.@marginBottom));
				Display.attach(layer, state, params);
			}
		}
	}
}