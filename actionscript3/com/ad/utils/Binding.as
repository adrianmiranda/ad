package com.ad.utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class Binding {
		
		public static function bind(raw:String, data:Object):String {
			if (data) {
				var bindingList:Vector.<String> = getBindings(raw);
				for each (var binding:String in bindingList) {
					if (isFlashVar(binding)) {
						raw = resolveFlashVar(raw, binding, data);
					}
					else if (isVariable(binding)) {
						raw = resolveVariable(raw, binding, data);
					}
					else if (isComplexContent(binding)) {
						// no yet implemented
						raw = resolveXML(raw, binding, data);
					}
					else if (data.hasOwnProperty(binding)) {
						raw = raw.replace('{' + binding + '}', data[binding]);
					}
				}
			}
			return raw;
		}
		
		public static function getBindings(raw:String):Vector.<String> {
			var bindingList:Vector.<String> = new Vector.<String>();
			if (raw) {
				var tries:uint = 0;
				var p1:int = 0 - 2;
				var p2:int = 0;
				while (p1 != 0 - 1 && tries++ < 20) {
					p1 = raw.indexOf('{', p1 + 1);
					p2 = raw.indexOf('}', p1);
					if (p1 != 0 - 1 && p2 != 0 - 1) {
						bindingList.push(raw.substring(p1 + 1, p2));
					}
				}
			}
			return bindingList;
		}
		
		public static function isValid(raw:String):Boolean {
			return true;
		}
		
		public static function hasBinding(raw:String):Boolean {
			return getBindings(raw).length ? true : false;
		}
		
		private static function resolveFlashVar(raw:String, binding:String, data:Object):String {
			if (data is DisplayObject && data.stage && data.stage is Stage) {
				if (data.stage.loaderInfo.parameters.hasOwnProperty(binding.substr(1))) {
					if (hasValue(data.stage.loaderInfo.parameters[binding.substr(1)])) {
						raw = raw.replace('{' + binding + '}', data.stage.loaderInfo.parameters[binding.substr(1)]);
					}
				}
				else if (Browser.queryString.hasOwnProperty(binding.substr(1))) {
					if (hasValue(Browser.queryString[binding])) {
						raw = raw.replace('{' + binding + '}', Browser.queryString[binding]);
					}
				}
				/*else if (hasValue($(name.substr(1)))) {
					raw = raw.replace('{' + binding + '}', $(binding));
				}*/
				else {
					raw = raw.replace('{' + binding + '}', '');
				}
			}
			return raw;
		}
		
		private static function resolveVariable(raw:String, binding:String, data:Object):String {
			if (data is DisplayObject) {
				if (data.hasOwnProperty(binding.substr(1))) {
					raw = raw.replace('{' + binding + '}', data[binding.substr(1)]);
				}
			}
			return raw;
		}
		
		private static function resolveXML(raw:String, binding:String, data:Object):String {
			if (data is XML || data is XMLList) {
				if (data.hasOwnProperty(binding)) {
					raw = raw.replace('{' + binding + '}', data[binding]);
				}
			}
			return raw;
		}
		
		private static function isFlashVar(raw:String):Boolean {
			return raw && raw.charAt(0) == '@' && isSimpleContent(raw);
		}
		
		private static function isVariable(raw:String):Boolean {
			return raw && raw.charAt(0) == '$' && isSimpleContent(raw);
		}
		
		private static function isComplexContent(raw:String):Boolean {
			return !isFlashVar(raw) && !isVariable(raw) && !isSimpleContent(raw);
		}
		
		private static function isSimpleContent(raw:String):Boolean {
			return raw && raw.indexOf('.') == -1 && raw.indexOf('/') == -1 ? true : false;
		}
		
		private static function hasValue(raw:*, binding:String = null):Boolean {
			return (raw != undefined && raw != null && raw != isNaN && raw != Infinity);
		}
	}
}