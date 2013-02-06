package com.ad.data {
	import com.ad.utils.ObjectUtil;
	
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @xml
	 *	<links>
	 *		<a id="link1">http://www.adrianmiranda.com.br/</a>
	 *		<a id="link2">http://www.othersample.com.br/</a>
	 *	</links>
	 *	
	 * @json
	 *	{ "links":
	 *		{
	 *			"link1":"http://www.adrianmiranda.com.br/",
	 *			"link2":"http://www.othersample.com.br/"
	 *		}
	 *	}
	 *	
	 * -----
	 * @usage
	 * import com.ad.external.Links;
	 * import com.ad.common._;
	 * 
	 * Links.fromObject({ "link1":"sample1", "link2":"sample2" });
	 * Links.fromJSON(links.json);
	 * Links.fromXML(links.xml);
	 * Links.parse('*');
	 * 
	 * trace('link 1:', _('link1'));
	 */
	final public class Links extends Proxy {
		public static var shortcutTarget:Links = new Links();
		public var useOwnPrintf:Boolean;
		public var data:Object;
		
		public function Links() {
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
		
		public static function parse(source:*, useOwnPrintf:Boolean = false, instance:Links = null):Links {
			if (source is String) {
				return Links.fromJSON(source, useOwnPrintf, instance);
			} else if (source is XML || source is XMLList) {
				return Links.fromXML(source, useOwnPrintf, instance);
			} else if (ObjectUtil.isObject(source)) {
				return Links.fromObject(source, useOwnPrintf, instance);
			}
			return Links.shortcutTarget;
		}
		
		public static function fromObject(object:Object, useOwnPrintf:Boolean = false, instance:Links = null):Links {
			var value:*;
			var property:Object;
			var links:Links = instance || Links.shortcutTarget;
			links.useOwnPrintf = useOwnPrintf;
			for (property in object) {
				value = object[property];
				if (ObjectUtil.hasComplexContent(value)) {
					Links.fromObject(value, useOwnPrintf, links);
				} else {
					links[property] = value;
				}
			}
			return links;
		}
		
		public static function fromJSON(json:String, useOwnPrintf:Boolean = false, instance:Links = null):Links {
			return Links.fromObject(ObjectUtil.decode(json, null), useOwnPrintf, instance);
		}
		
		public static function fromXML(xml:*, useOwnPrintf:Boolean = false, instance:Links = null):Links {
			var node:XML;
			var links:Links = instance || Links.shortcutTarget;
			links.useOwnPrintf = useOwnPrintf;
			for each (node in xml.children()) {
				if (node.hasComplexContent()) {
					Links.fromXML(node, useOwnPrintf, links);
				} else {
					links[String(node.@id)] = String(node.text());
				}
			}
			return links;
		}
	}
}