package com.ad.common {
	import flash.text.TextField;
	import flash.utils.describeType;

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public function cloneTextField(textField:TextField, replace:Boolean = false):TextField {
		var clone:TextField = new TextField();
		var description:XML = describeType(textField);
		for each (var item:XML in description.accessor) {
			if (item.@access != 'readonly') {
				try {
					clone[item.@name] = textField[item.@name];
				} catch(error:Error) {
					// N/A yet.
				}
			}
		}
		clone.defaultTextFormat = textField.getTextFormat();
		if (textField.parent && replace) {
			textField.parent.addChild(clone);
			textField.parent.removeChild(textField);
			textField = null;
		}
		return clone;
	}
}