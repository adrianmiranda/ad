package com.ad.display {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.describeType;

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class Text extends TextField {
		private var _recordedHeight:Number;
		private var _heightLock:Boolean; 
		private var _target:TextField;
		
		public function Text(target:TextField = null, debug:Boolean = false) {
			super();
			this._target = target;
			if (this._target) {
				var description:XML = describeType(this._target);
				for each (var item:XML in description.accessor) {
					if (item.@access != 'readonly') {
						this[item.@name] = this._target[item.@name];
					}
				}
			}
			super.condenseWhite = true;
			super.defaultTextFormat = this._target.getTextFormat();
			this._recordedHeight = super.height;
			if (debug) {
				super.border = true;
				super.borderColor = 0xFF0000;
			}
		}

		public function get target():TextField {
			return this._target || this;
		}
		
		override public function set htmlText(value:String):void {
			this._heightLock = true;
			super.autoSize = TextFieldAutoSize.LEFT;
			super.htmlText = value;
			this._recordedHeight = height;
			super.autoSize = TextFieldAutoSize.NONE;
			super.height = this._recordedHeight + super.getTextFormat().leading + 1;
			this._heightLock = false;
		}
		
		override public function get height():Number {
			return (this._heightLock) ? super.height : this._recordedHeight;
		}

		override public function toString():String {
			return '[Text ' + super.name + ']';
		}
	}
}