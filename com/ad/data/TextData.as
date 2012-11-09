package com.ad.data
{
	public class TextData extends ValueObject
	{
		private var _trackid:*;
		private var _text:*;
		
		public function TextData(vars:Object = null)
		{
			super(vars);
		}
		
		public function get trackid():*{return this._trackid;}
		public function set trackid(value:*):void{this._trackid = value;}
		
		public function get text():*{return this._text;}
		public function set text(value:*):void{this._text = value;}
	}
}