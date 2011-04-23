package com.ad.controls {
	import com.ad.proxy.nsmedia;
	import com.ad.data.EqualizeParse;
	
	public final class MasterEqualizer {
		private static var _self:MasterEqualizer = new MasterEqualizer();
		private var _equalize:EqualizeParse;
		
		public static function getInstance():MasterEqualizer {
			return _self;
		}
		
		public function get pan():Number {
			return this._equalize.pan;
		}
		
		public function set pan(value:Number):void {
			this._equalize.pan = value;
			MediaControl.equalize(this._equalize);
		}
		
		public function get leftSpeak():Number {
			return this._equalize.leftSpeak;
		}
		
		public function set leftSpeak(value:Number):void {
			this._equalize.leftSpeak = value;
			MediaControl.equalize(this._equalize);
		}
		
		public function get rightSpeak():Number {
			return this._equalize.rightSpeak;
		}
		
		public function set rightSpeak(value:Number):void {
			this._equalize.rightSpeak = value;
			MediaControl.equalize(this._equalize);
		}
		
		public function get volume():Number {
			return this._equalize.volume;
		}
		
		public function set volume(value:Number):void {
			this._equalize.volume = value;
			MediaControl.equalize(this._equalize);
		}
		
		/** @private */
		nsmedia function get equalize():EqualizeParse {
			return this._equalize;
		}
	}
}