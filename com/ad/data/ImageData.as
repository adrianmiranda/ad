package com.ad.data
{
	import flash.utils.ByteArray;
	
	public class ImageData extends ValueObject
	{
		private var _data:ByteArray;
		private var _trackid:*;
		
		public function ImageData(vars:Object = null)
		{
			super(vars);
		}
		
		public function get trackid():*{return this._trackid;}
		public function set trackid(value:*):void{this._trackid = value;}
		
		public function get data():ByteArray{return this._data;}
		public function set data(value:ByteArray):void{this._data = value;}
	}
}