package com.ad.data {
	import com.ad.proxy.nsmedia;
	
	use namespace nsmedia;
	public final class EqualizeParse {
		public var pan:Number;
		public var volume:Number;
		public var leftSpeak:Number;
		public var rightSpeak:Number;
		
		public function EqualizeParse(volume:Number = 1, pan:Number = 0, leftSpeak:Number = 1, rightSpeak:Number = 1) {
			this.pan = pan;
			this.volume = volume;
			this.leftSpeak = leftSpeak;
			this.rightSpeak = rightSpeak;
		}
		
		public function toString():String {
			return '[EqualizeParse]';
		}
	}
}