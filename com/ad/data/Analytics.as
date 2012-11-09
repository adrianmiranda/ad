package com.ad.data {
	import com.ad.utils.ObjectUtil;
	import com.ad.utils.XMLUtil;
	
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * @xml
	 * 
	 * @json
	 * 
	 * -----
	 * @usage
	 * import com.ad.external.Analytics;
	 * import com.ad.common.track
	 * 
	 * Analytics.fromObject({ "tag1":"sample1", "tag2":"sample2" });
	 * Analytics.fromJSON(tracks.json);
	 * Analytics.fromXML(tracks.xml);
	 * Analytics.parse('*');
	 * 
	 * trace('tag 1:', track('/track'));
	 */
	public class Analytics extends Proxy {
		public static var shortcutTarget:Analytics = new Analytics();
		public var useOwnPrintf:Boolean;
		public var data:Object;
		
		public function Analytics() {
			this.data = new Object();
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean {
			return delete this.data[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			this.data[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):* {
			return this.usePrintf(name) && this.useOwnPrintf ? (printf(this.data[name], this) || '??? ' + name) : this.data[name];
		}
		
		override flash_proxy function hasProperty(name:*):Boolean {
			return name in this.data;
		}
		
		public function usePrintf(name:*):Boolean {
			return this.data[name] == null || this.data[name] is String || !isNaN(this.data[name]);
		}
		
		public function useBinding(name:*):Boolean {
			return this.usePrintf(name);
		}
		
		public static function parse(source:*, useOwnPrintf:Boolean = false, instance:Analytics = null):Analytics {
			if (source is String) {
				return Analytics.fromJSON(source, useOwnPrintf, instance);
			} else if (source is XML || source is XMLList) {
				return Analytics.fromXML(source, useOwnPrintf, instance);
			} else if (ObjectUtil.isObject(source)) {
				return Analytics.fromObject(source, useOwnPrintf, instance);
			}
			return Analytics.shortcutTarget;
		}
		
		public static function fromObject(object:Object, useOwnPrintf:Boolean = false, instance:Analytics = null):Analytics {
			var value:*;
			var property:Object;
			var tags:Analytics = instance || Analytics.shortcutTarget;
			tags.useOwnPrintf = useOwnPrintf;
			for (property in object) {
				value = object[property];
				if (ObjectUtil.hasComplexContent(value)) {
					Analytics.fromObject(value, useOwnPrintf, tags);
				} else {
					tags[property] = value;
				}
			}
			return tags;
		}
		
		public static function fromJSON(json:String, useOwnPrintf:Boolean = false, instance:Analytics = null):Analytics {
			return Analytics.fromObject(ObjectUtil.decode(json, null), useOwnPrintf, instance);
		}
		
		public static function fromXML(xml:*, useOwnPrintf:Boolean = false, instance:Analytics = null):Analytics {
			var node:XML;
			var tags:Analytics = instance || Analytics.shortcutTarget;
			tags.useOwnPrintf = useOwnPrintf;
			for each (node in xml.children()) {
				if (node.hasComplexContent()) {
					Analytics.fromXML(node, useOwnPrintf, tags);
				} else {
					tags[String(node.@id)] = String(XMLUtil.cdata(node.tag));
				}
			}
			return tags;
		}
	}
}