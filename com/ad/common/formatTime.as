package com.ad.common {
	
	public function formatTime(time:Number, maskFormat:String = 'hh:mm:ss:mmmm'):String {
		var output:String = new String();
		var factor:uint = Math.round(((time % 1) * 10) * 100);
		var miliseconds:String = String((factor < 10) ? '000' + force2Digits(factor) : (factor < 100) ? '00' + force2Digits(factor) : (factor < 1000) ? '0' + force2Digits(factor) : factor);
		var seconds:uint = Math.round(time);
		var minutes:uint = 0;
		var hours:uint = 0;
		var id:int = -1;
		if (seconds > 0) {
			while (seconds > 59) {
				minutes ++; seconds -= 60;
				while (minutes > 59) {
					hours ++; minutes -= 60; seconds -= 60;
				}
			} 
			if (maskFormat == 'hh:mm:ss') return force2Digits(hours) + ':' + force2Digits(minutes) + ':' + force2Digits(seconds);
			else if (maskFormat == 'mm:ss') return force2Digits(minutes) + ':' + force2Digits(seconds);
			return force2Digits(hours) + ':' + force2Digits(minutes) + ':' + force2Digits(seconds) + ':' + miliseconds;
		} else {
			if (maskFormat == 'hh:mm:ss') return '00:00:00';
			else if (maskFormat == 'mm:ss') return '00:00';
			return '00:00:00:0000';
		}
	}
}