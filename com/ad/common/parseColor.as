package com.ad.common {
	
	public function parseColor(value:String):Number {
		if (value.charAt(0) == '#') {
			value = value.substr(1);
		}
		if (value.charAt(1) == 'x') {
			value = value.substr(2);
		}
		if (value.length <= 3) {
			var color:String = '';
			while (color.length < 6) {
				color += value;
			}
			value = color;
		}
		if (value.length == 3) {
			var r:Number = parseInt(value.charAt(0), 16);
			var g:Number = parseInt(value.charAt(1), 16);
			var b:Number = parseInt(value.charAt(2), 16);
			return Math.round(r * 255 / 15) << 16 | Math.round(g * 255 / 15) << 8 | Math.round(b * 255 / 15);
		} else if (value.length != 6) {
			trace('*** Error: Invalid Color');
			return null;
		}
		return parseInt(value, 16);
	}
}