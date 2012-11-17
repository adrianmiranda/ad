package com.ad.data
{
	public class PlayStatus extends ValueObject
	{
		private var _level:*;
		private var _code:*;
		
		public function PlayStatus(vars:Object = null)
		{
			super(vars);
		}
		
		public function get level():*{return this._level;}
		public function set level(value:*):void{this._level = value;}
		
		public function get code():*{return this._code;}
		public function set code(value:*):void{this._code = value;}
	}
}