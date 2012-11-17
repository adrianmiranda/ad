package com.ad.interfaces {
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	public interface IThumb extends IButton {
		function load(url:String):void;
		function loadBytes(bytes:ByteArray):void;
		function get content():DisplayObject;
		function get url():String;
	}
}