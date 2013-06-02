package com.ad.ui {
	import com.ad.utils.ArrayUtil;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class KeyCombo {
		private var _keyCodes:Array;
		private var _id:String;
		
		public function KeyCombo(id:String, ...keys:Array) {
			this._id = id;
			if (!this._id) trace(this.toString(), 'error');
			if (keys.length < 2) trace(this.toString(), 'error');
			var total:uint = keys.length;
			while (total--) {
				if (!(keys[total] is uint)) {
					trace(this.toString(), 'error');
				}
			}
			this._keyCodes = keys;
		}
		
		public function get keyCodes():Array {
			return this._keyCodes.concat();
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function equals(keyCombo:KeyCombo):Boolean {
			if (keyCombo == this) return true;
			return ArrayUtil.strictlyEquals(this.keyCodes, keyCombo.keyCodes);
		}
		
		public function toString():String {
			return '[KeyCombo ' + (this._id + ' (' + this._keyCodes) + ')]';
		}
	}
}