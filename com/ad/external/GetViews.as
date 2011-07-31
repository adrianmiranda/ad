package com.ad.external {
	import com.ad.data.URI;
	import com.ad.common.parseBoolean;
	import com.ad.common.parseNumber;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary;
	
	public class GetViews extends Proxy {
		private static var instanceCollection:Array = new Array();
		private var _menuArray:Array;
		private var _multitonKey:String;
		private var _deeplink:String;
		private var _title:String;
		
		public function GetViews(key:String) {
			if (instanceCollection[key]) throw new Error('Instantiation failed: Use GetViews.fromFileID(key) instead of new.');
			this._multitonKey = key;
			instanceCollection[this._multitonKey] = this;
			this._menuArray = new Array();
			this._deeplink = '';
		}
		
		public static function appendViews(value:XML, at:String = 'default'):void {
			GetViews.fromFileID('views_' + at).viewsFromXML(value);
		}
		
		public static function getMenuArray(at:String = 'default'):Array {
			return GetViews.fromFileID('views_' + at).getMenuArray();
		}
		
		public static function getTitle(at:String = 'default'):String {
			return GetViews.fromFileID('views_' + at).getTitle();
		}
		
		public static function fromFileID(key:String = ''):GetViews {
			key = key ? key : 'default';
			if (!instanceCollection[key]) instanceCollection[key] = new GetViews(key);
			return instanceCollection[key];
		}
		
		private function viewsFromXML(xml:*):void {
			var count:int;
			var section:XML;
			var hasDefault:Boolean;
			this._title = String(xml.@title || xml.title);
			for each (section in xml.section) {
				
				var defaultSection:Boolean = parseBoolean(String(section.@default || section.default));
				var errorSection:Boolean = parseBoolean(String(section.@error || section.error));
				
				var data:URI = new URI();
				data.id = String(section.@id || section.id);
				data.label = String(section.@label || section.label);
				data.window = String(section.@['window'] || section['window']);
				data.source = String(section.@['class'] || section['class']);
				data.phase = Math.max(1, parseNumber(section.@phase || section.phase));
				
				if (data.window) {
					data.uri = String(section.@uri || section.uri);
				} else {
					this._deeplink += String(section.@uri || section.uri);
					data.uri = this._deeplink;
				}
				data.layer = String(section.@layer || section.layer);
				data.menu = String(section.@menu || section.menu) ? parseBoolean(String(section.@menu || section.menu)) : true;
				data.contextMenu = parseBoolean(String(section.@contextMenu || section.contextMenu));
				
				if (!hasDefault && data.window == '') {
					data.isUriError = true;
					data.isUriDefault = true;
					hasDefault = true;
				}
				if (defaultSection) {
					for each (var uris:URI in this._menuArray) {
						uris.isUriDefault = false;
					}
					data.isUriDefault = true;
				}
				if (errorSection) {
					data.isUriError = true;
				}
				
				this._menuArray.push(data);
				count++;
				
				if (section.hasOwnProperty('section')) {
					this.viewsFromXML(section);
				} else {
					// no yet implemented
				}
				
				this._deeplink = this._deeplink.substring(0, this._deeplink.lastIndexOf('/'));
			}
		}
		
		private function getTitle():String {
			return this._title;
		}
		
		private function getMenuArray():Array {
			return this._menuArray;
		}
	}
}