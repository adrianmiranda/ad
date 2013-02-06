package com.ad.common {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://stackoverflow.com/questions/5802287/as3-textfield-not-applying-b-tag
	 */
	public function applyTextFormat(textField:TextField, textFormat:TextFormat, resize:Boolean = true):TextFormat {
		textField.embedFonts = true;
		textField.defaultTextFormat = textFormat;
		textField.setTextFormat(textFormat);
		if (resize) {
			textField.width = Math.ceil(textField.textWidth + 6);
			textField.height = Math.ceil(textField.textHeight + 5);
		}
		return textField.defaultTextFormat;
	}
}