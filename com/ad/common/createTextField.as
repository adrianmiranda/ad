package com.ad.common {
	import flash.text.TextFieldType;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function createTextField(textformat:TextFormat = null, autoSize:String = 'left', type:String = 'dynamic'):TextField {
		var textField:TextField = new TextField();
		if (textformat) applyTextFormat(textField, textformat);
		textField.autoSize = autoSize;
		textField.width = Math.ceil(textField.textWidth) + 6;
		textField.height = Math.ceil(textField.textHeight) + 5;
		textField.antiAliasType = AntiAliasType.ADVANCED;
		textField.selectable = type == TextFieldType.DYNAMIC ? false : true;
		textField.wordWrap = false;
		textField.multiline = true;
		textField.type = type;
		return textField;
	}
}