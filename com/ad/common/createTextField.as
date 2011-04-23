package com.ad.common {
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public function createTextField(textformat:TextFormat = null, autoSize:String = 'left'):TextField {
		var textField:TextField = new TextField();
		if (textformat) applyTextFormat(textField, textformat);
		if (autoSize) textField.autoSize = autoSize;
		textField.width = Math.ceil(textField.textWidth) + 6;
		textField.height = Math.ceil(textField.textHeight) + 5;
		textField.antiAliasType = AntiAliasType.ADVANCED;
		textField.selectable = false;
		textField.wordWrap = false;
		return textField;
	}
}