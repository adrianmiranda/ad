package com.ad.data {
	import com.ad.utils.ObjectUtil;
	import com.ad.utils.XMLUtil;
	
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * @xml
	 *	<texts>
	 *		<text id="text1">sample1</text>
	 *		<text id="text2">sample2</text>
	 *	</texts>
	 *	
	 * @json
	 *	{ "texts":
	 *		{
	 *			"text1":"sample1",
	 *			"text2":"sample2"
	 *		}
	 *	}
	 *	
	 * -----
	 * @usage
	 * import com.ad.external.Texts;
	 * import com.ad.common.i18n;
	 * 
	 * Texts.fromObject({ "text1":"sample1", "text2":"sample2" });
	 * Texts.fromJSON(texts.json);
	 * Texts.fromXML(texts.xml);
	 * Texts.parse('*');
	 * 
	 * trace('text 1:', i18n('text1'));
	 */
	final public class Texts extends Proxy {
		public static var shortcutTarget:Texts = new Texts();
		public var useOwnPrintf:Boolean;
		public var data:Object;
		
		public function Texts() {
			this.data = new Object();
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean {
			return delete this.data[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			this.data[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):* {
			return this.usePrintf(name) && this.useOwnPrintf ? (printf(this.data[name], this) || '??? ' + name) : this.data[name] || '??? ' + name;
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
		
		public static function parse(source:*, useOwnPrintf:Boolean = false, instance:Texts = null):Texts {
			if (source is String) {
				return Texts.fromJSON(source, useOwnPrintf, instance);
			} else if (source is XML || source is XMLList) {
				return Texts.fromXML(source, useOwnPrintf, instance);
			} else if (ObjectUtil.isObject(source)) {
				return Texts.fromObject(source, useOwnPrintf, instance);
			}
			return Texts.shortcutTarget;
		}
		
		public static function fromObject(object:Object, useOwnPrintf:Boolean = false, instance:Texts = null):Texts {
			var value:*;
			var property:Object;
			var texts:Texts = instance || Texts.shortcutTarget;
			texts.useOwnPrintf = useOwnPrintf;
			for (property in object) {
				value = object[property];
				if (ObjectUtil.hasComplexContent(value)) {
					Texts.fromObject(value, useOwnPrintf, texts);
				} else {
					texts[property] = value;
				}
			}
			return texts;
		}
		
		public static function fromJSON(json:String, useOwnPrintf:Boolean = false, instance:Texts = null):Texts {
			return Texts.fromObject(ObjectUtil.decode(json, null), useOwnPrintf, instance);
		}
		
		public static function fromXML(xml:*, useOwnPrintf:Boolean = false, instance:Texts = null):Texts {
			var node:XML;
			var texts:Texts = instance || Texts.shortcutTarget;
			texts.useOwnPrintf = useOwnPrintf;
			for each (node in xml.children()) {
				if (node.hasComplexContent()) {
					Texts.fromXML(node, useOwnPrintf, texts);
				} else {
					texts[String(node.@id)] = String(node.text());
				}
			}
			return texts;
		}
	}
}