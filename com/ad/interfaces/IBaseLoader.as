package com.ad.interfaces {
	
	public interface IBaseLoader extends IBase {
		function get bytesLoaded():Number;
		function get bytesTotal():Number;
		function get percentage():uint;
		function get progress():Number;
		function get loadTime():Number;
		function get secondsLeft():Number;
		function get kbps():Number;
		function bytes(bytesLoaded:Number, bytesTotal:Number):void;
		function fault(message:String):void;
	}
}