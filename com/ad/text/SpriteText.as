package com.ad.text {
	import com.ad.common.applyTextFormat;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	public class SpriteText extends TextField {
		
		public function SpriteText(textFormat:TextFormat = null, resize:Boolean = true, autoSize:String = 'left') {
			if (textFormat) this.textFormat(textFormat, resize);
			if (autoSize) super.autoSize = autoSize;
			super.antiAliasType = AntiAliasType.ADVANCED;
			super.selectable = false;
			super.wordWrap = false;
		}
		
		public function restrictName():void {
			super.restrict = 'A-Za-zÀ-Ûà-û ';
		}
		
		public function restrictEmail():void {
			super.restrict = 'A-Za-z0-9._@\\-';
		}
		
		public function restrictNumber():void {
			super.restrict = '0-9';
		}
		
		public function restrictToUpperCase():void {
			super.restrict = '^a-z';
		}
		
		public function restrictToLowerCase():void {
			super.restrict = '^A-Z';
		}
		
		public function textFormat(textFormat:TextFormat, resize:Boolean = true):void {
			applyTextFormat(this, textFormat, resize);
		}
		
		public function move(x:Number, y:Number):void {
			super.x = Math.round(x);
			super.y = Math.round(y);
		}
		
		public function size(width:Number, height:Number):void {
			super.width = width;
			super.height = height;
		}
		
		public function set scale(value:Number):void {
			super.scaleX = super.scaleY = value;
		}
		
		override public function toString():String {
			return '[SpriteText ' + super.name + ']';
		}
	}
}