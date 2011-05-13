package com.ad.external
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary;
	import com.ad.utils.Rope;
	
	public class GetValues extends Proxy
	{
		private static var instanceCollection:Array = new Array();
		private static var jsFunction:String;
		private var _valueDictionary:Dictionary;
		private var _multitonKey:String;
		
		public function GetValues(key:String)
		{
			if (instanceCollection[key]) throw new Error('Instantiation failed: Use GetValues.instance instead of new.');
			this._multitonKey = key;
			instanceCollection[this._multitonKey] = this;
			this._valueDictionary = new Dictionary(true);
		}
		
		public static function appendTrack(value:XML, at:String = 'default'):void {
			jsFunction = value.@['jsFunction'];
			GetValues.fromFileID('track_' + at).trackFromXML(value);
			GetValues.fromFileID('track_' + at).parseBindings();
		}
		
		public static function appendTexts(value:XML, at:String = 'default'):void {
			GetValues.fromFileID('texts_' + at).valuesFromXML(value);
			GetValues.fromFileID('texts_' + at).parseBindings();
		}
		
		public static function appendLinks(value:XML, at:String = 'default'):void {
			GetValues.fromFileID('links_' + at).valuesFromXML(value);
			GetValues.fromFileID('links_' + at).parseBindings();
		}
		
		public static function appendVars(parameters:Object, at:String = 'default'):void {
			GetValues.fromFileID('parameters_' + at).paramsFromFlashVars(parameters);
			GetValues.fromFileID('parameters_' + at).parseBindings();
		}
		
		public static function appendParams(parameters:XML, at:String = 'default'):void {
			GetValues.fromFileID('parameters_' + at).paramsFromXML(parameters);
			GetValues.fromFileID('parameters_' + at).parseBindings();
		}
		
		public static function fromFileID(key:String = ''):GetValues {
			key = key ? key : 'default';
			if (!instanceCollection[key]) instanceCollection[key] = new GetValues(key);
			return instanceCollection[key];
		}
		
		override flash_proxy function callProperty(name:*, ...rest):* {
			throw new Error('WARNING: There is no method called: ' + name + ' in GetValues[' + this._multitonKey + ']');
			return null;
		}
		
		override flash_proxy function setProperty(name:*, propertyValue:*):void {
			this._valueDictionary[name] = propertyValue;
		}
		
		override flash_proxy function getProperty(name:*):* {
			return this._valueDictionary[name] || '??? ' + name;
		}
		
		private function valuesFromXML(xml:*):void {
			var child:XML;
			var id:String;
			for each (child in xml.children()) {
				if (child.hasComplexContent()) {
					this.valuesFromXML(child);
				} else {
					id = String(child.@id || child.id);
					if (id) {
						instanceCollection[this._multitonKey][id] = String(child.text() || child.@value);
					}
				}
			}
		}
		
		private function trackFromXML(xml:*):void {
			var child:XML;
			var id:String;
			var tag:String;
			var code:String;
			var jsMethod:String;
			for each (child in xml.children()) {
				if (child.hasComplexContent()) {
					this.trackFromXML(child);
				} else {
					id = String(child.@id || child.id);
					tag = (child.text() || child.@value);
					code = String(child.@code || child.code);
					jsMethod = String(child.@['jsFunction'] || child['jsFunction']);
					if (id) {
						instanceCollection[this._multitonKey][id] = { code:code, tag:tag, jsFunction:(jsMethod || jsFunction) };
					}
				}
			}
		}
		
		private function paramsFromXML(xml:*):void {
			var child:XML;
			for each (child in xml.children()) {
				instanceCollection[this._multitonKey][child.name()] = (child.toString() || child.@value);
			}
		}
		
		private function paramsFromFlashVars(parameters:Object):void {
			for (var id:String in parameters) {
				instanceCollection[this._multitonKey][id] = parameters[id];
			}
		}
		
		private function parseBindings():void {
			var key:String;
			for (key in this._valueDictionary) {
				if (Rope.hasBinding(this._valueDictionary[key])) {
					if (!Rope.isInvalidBinding(this._valueDictionary[key])) {
						// TODO: properly implement
						var substitutions:Object = getSubstitutions(Rope.getBindingSubstitutions(this._valueDictionary[key]));
						Rope.binding(this._valueDictionary[key], substitutions);
					}
				}
			}
		}
		
		private function getSubstitutions(list:Array):Object {
			var key:String;
			var id:int = list.length;
			var data:Object = new Object();
			for (id--) {
				key = list[id];
				if (this._valueDictionary[key]) {
					data[key] = this._valueDictionary[key];
				}
			}
			return data;
		}
	}
}