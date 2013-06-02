package com.ad.text {
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class InputMask {
		private var $dispose:Boolean;
		private var _charCollection:Array;
		private var _textField:TextField;
		
		public function InputMask(textField:TextField) {
			this.$dispose = true;
			this._textField = textField;
			this._textField.restrict = '0-9';
			this._textField.addEventListener(KeyboardEvent.KEY_DOWN, this.checkInputMask);
		}
		
		public function setMask(maskFormat:String = '00-00-0000'):void {
			if (this.$dispose) {
				this._textField.maxChars = maskFormat.length;
				this._charCollection = [];
				for (var id:int = 0; id < maskFormat.length; id++) {
					if (maskFormat.charAt(id) != '0') {
						this._charCollection.push( { gap:id, character:maskFormat.charAt(id) } );
					}
				}
			}
		}
		
		private function checkInputMask(event:KeyboardEvent):void {
			for (var id:int = 0; id < this._charCollection.length; id++) {
				if (event.keyCode != Keyboard.BACKSPACE && event.keyCode != Keyboard.DELETE) {
					if (this._textField.length == this._charCollection[id].gap) {
						this._textField.appendText(this._charCollection[id].character);
						this._textField.setSelection(this._charCollection[id].gap + 1, this._charCollection[id].gap + 1);
					}
				}
			}
		}
		
		public function die(killTextField:Boolean = false):void {
			if (this.$dispose) {
				this.$dispose = false;
				this._textField.removeEventListener(KeyboardEvent.KEY_DOWN, this.checkInputMask, false);
				var id:int = -1;
				while (++id < this._charCollection.length) {
					delete this._charCollection[id];
					this._charCollection.splice(id, 1);
					this._charCollection[id] = null;
				}
				this._charCollection = null;
				if (killTextField && this._textField && this._textField.stage) {
					this._textField.parent.removeChild(this._textField);
				}
				this._textField = null;
			}
		}
	}
}