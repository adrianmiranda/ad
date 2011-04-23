package com.ad.common {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public function applyTextFormat(textField:TextField, textFormat:TextFormat, resize:Boolean = true):void {
		textField.embedFonts = true;
		textField.defaultTextFormat = textFormat;
		textField.setTextFormat(textFormat);
		if (resize) {
			textField.width = Math.ceil(textField.textWidth + 6);
			textField.height = Math.ceil(textField.textHeight + 5);
		}
	}
}