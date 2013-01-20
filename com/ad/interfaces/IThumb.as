package com.ad.interfaces {
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IThumb extends IButton {
		function load(urlOrRequest:*):void;
		function loadBytes(bytes:ByteArray):void;
		function get content():DisplayObject;
		function get url():String;
	}
}