package com.ad.external {
	import com.ad.display.Layer;
	import com.ad.proxy.nsdisplay;
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
			if (instanceCollection[key]) throw new Error('Instantiation failed: Use GetLayers.instance instead of new.');
			instanceCollection[this._multitonKey] = this;
			this._layerDictionary = new Dictionary(true);
		}
		
		public static function appendLayers(value:*, container:Sprite, at:String = 'default'):void {
			holder = container;
			GetLayers.fromFileID('layers_' + at).layersFromXML(XML(value), container);
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
			throw new Error('WARNING: There is no method called: ' + name + ' in GetLayers[' + this._multitonKey + ']');
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
				throw new Error('Layer: ' + name + ' doesn\'t exist');
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
					(layer as Layer).setLocked(node.@locked);
					(layer as Layer).setShowRegistrationPoint(node.@showRegistrationPoint);
					layer.x = parseFloat(node.@x || node.x || '0'); // temporary
					layer.y = parseFloat(node.@y || node.y || '0'); // temporary
					container.addChild(layer);
					this._layerDictionary[layer.name] = layer;
					this.arrange(layer, node);
				}
				if (node.hasOwnProperty('layer')) {
					this.layersFromXML(node, layer);
				}
			}
		}
		
		private function arrange(layer:Sprite, node:XML):void {
			/*var anchors:uint = 0;
			var align:String = String(node.@align).toLowerCase();
			var props:Object = new Object();
			
			if (Rope.trim(align) != '') {
				if (align.indexOf('top') != -1) anchors += Align.TOP;
				if (align.indexOf('bottom') != -1) anchors += Align.BOTTOM;
				if (align.indexOf('middle') != -1) anchors += Align.MIDDLE;
				if (align.indexOf('left') != -1) anchors += Align.LEFT;
				if (align.indexOf('center') != -1) anchors += Align.CENTER;
				if (align.indexOf('right') != -1) anchors += Align.RIGHT;
				if (align.indexOf('none') != -1) anchors += Align.NONE;
				
				if (Rope.trim(node.@marginLeft) != '') props.marginLeft = parseFloat(this._app.getParsedValueOf(node.@marginLeft));
				if (Rope.trim(node.@marginRight) != '') props.marginRight = parseFloat(this._app.getParsedValueOf(node.@marginRight));
				if (Rope.trim(node.@marginTop) != '') props.marginTop = parseFloat(this._app.getParsedValueOf(node.@marginTop));
				if (Rope.trim(node.@marginBottom) != '') props.marginBottom = parseFloat(this._app.getParsedValueOf(node.@marginBottom));
				
				if (Rope.trim(node.@width)) props.width = parseFloat(this._app.getParsedValueOf(node.@width));
				if (Rope.trim(node.@height)) props.height = parseFloat(this._app.getParsedValueOf(node.@height));
				
				Align.add(layer, anchors, props);
			}*/
		}
	}
}