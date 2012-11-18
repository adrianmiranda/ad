package com.ad.data {
	import flash.display.Sprite;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: 
	 */
	public class ValueObject {
		private var _id:*;
		
		public function ValueObject(vars:Object = null) {
			if (vars != null) {
				for (var property:String in vars) {
					this[property] = vars[property];
				}
			}
		}
		
		public function set id(value:*):void {
			this._id = value;
		}
		
		public function get id():* {
			return this._id;
		}
		
		/*private function debug(info:Object, indent:uint = 0):void {
			var indentString:String = '';
			var index:uint;
			var property:String;
			var value:*;
			
			for (index = 0; index < indent; index++) {
				indentString += '\t';
			}
			
			for (property in info) {
				value = info[property];
				if (typeof(value) == 'object') {
					trace(indentString + ' ' + property + ': [Object]');
					this.debug(value, indent + 1);
				} else {
					trace(indentString + ' ' + property + ': ' + value);
				}
			}
		}*/
	}
}