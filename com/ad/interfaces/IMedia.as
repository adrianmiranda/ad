package com.ad.interfaces {
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public interface IMedia {
		function get volume():Number;
		function set volume():Number;
		function get position():Number;
		function get duration():Number;
		function load(stream:URLRequest, context:SoundLoaderContext = null):void
		function play(startTime:Number = -1, loops:int = 0, soundTransform:SoundTransform = null):SoundChannel;
		function pause():void;
		function stop(close:Boolean = true):void;
	}
}