package com.ad.data {
	import com.ad.utils.ObjectUtil;
	
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	import printf;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @xml
	 *	<parameters>
	 *		<output>
	 *			<debug benchmark="false" />
	 *			<debug omitTraces="true" />
	 *			<debug warnings="true" />
	 *			<debug verboseStackTraces="true" />
	 *			<debug showActionScriptWarnings="true" />
	 *			<debug showBindingWarnings="true" />
	 *			<debug showDeprecationWarnings="true" />
	 *			<debug showUnusedTypeSelectorWarnings="true" />
	 *		</output>
	 *	<parameters>
	 *	
	 * @json 
	 *	{ "parameters":
	 *		{ "output":
	 *			{
	 *				"debug-benchmark":false,
	 *				"debug-omitTraces":true,
	 *				"debug-warnings":true,
	 *				"debug-verboseStackTraces":true,
	 *				"debug-showActionScriptWarnings":true,
	 *				"debug-showBindingWarnings":true,
	 *				"debug-showDeprecationWarnings":true,
	 *				"debug-showUnusedTypeSelectorWarnings":true
	 *			}
	 *		}
	 *	}
	 *	
	 * -----
	 * @usage
	 * import com.ad.external.Parameters;
	 * import com.ad.common.$;
	 * 
	 * Parameters.fromObject(stage.loaderInfo.parameters);
	 * Parameters.fromJSON(parameters.json);
	 * Parameters.fromXML(parameters.xml);
	 * 
	 * trace('benchmark:', $('debug-benchmark'));
	 */
	dynamic final public class Parameters extends Proxy {
		public static var shortcutTarget:Parameters = new Parameters();
		public var useOwnPrintf:Boolean;
		public var data:Object;
		
		public function Parameters() {
			this.data = new Object();
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean {
			return delete this.data[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			this.data[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):* {
			return this.usePrintf(name) && this.useOwnPrintf ? (printf(this.data[name], this) || '') : this.data[name];
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
		
		public static function parse(source:*, useOwnPrintf:Boolean = false, instance:Parameters = null):Parameters {
			if (source is String) {
				return Parameters.fromJSON(source, useOwnPrintf, instance);
			} else if (source is XML || source is XMLList) {
				return Parameters.fromXML(source, useOwnPrintf, instance);
			} else if (ObjectUtil.isObject(source)) {
				return Parameters.fromObject(source, useOwnPrintf, instance);
			}
			return Parameters.shortcutTarget;
		}
		
		public static function fromObject(object:Object, useOwnPrintf:Boolean = false, instance:Parameters = null):Parameters {
			var value:*;
			var property:Object;
			var parameters:Parameters = instance || Parameters.shortcutTarget;
			parameters.useOwnPrintf = useOwnPrintf;
			for (property in object) {
				value = object[property];
				if (ObjectUtil.hasComplexContent(value)) {
					Parameters.fromObject(value, useOwnPrintf, parameters);
				} else {
					parameters[property] = value;
				}
			}
			return parameters;
		}
		
		public static function fromJSON(json:String, useOwnPrintf:Boolean = false, instance:Parameters = null):Parameters {
			return Parameters.fromObject(ObjectUtil.decode(json, null), useOwnPrintf, instance);
		}
		
		public static function fromXML(xml:*, useOwnPrintf:Boolean = false, instance:Parameters = null):Parameters {
			var node:XML;
			var parameters:Parameters = instance || Parameters.shortcutTarget;
			parameters.useOwnPrintf = useOwnPrintf;
			for each (node in xml.children()) {
				if (node.hasComplexContent()) {
					Parameters.fromXML(node, useOwnPrintf, parameters);
				} else {
					var name:String;
					var attribute:XML;
					for each (attribute in node.@*) {
						name = String(node.name()) + '-' + String(attribute.name());
						parameters[name] = String(attribute.toXMLString());
					}
				}
			}
			return parameters;
		}
	}
}