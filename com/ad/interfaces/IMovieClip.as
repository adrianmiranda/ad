package com.ad.interfaces {
	
	public interface IMovieClip extends IEventControl {
		function gotoAndStop(frame:Object, scene:String = null):void;
		function gotoAndPlay(frame:Object, scene:String = null):void;
		function prevFrame():void;
		function nextFrame():void;
		function nextScene():void;
		function prevScene():void;
		function stop():void;
		function play():void;
		function playTo(frame:Object, vars:Object = null):void;
		function playToBeginAndStop(vars:Object = null):void;
		function playToEndAndStop(vars:Object = null):void;
		function loopBetween(from:Object = 1, to:Object = 0, yoyo:Boolean = false, vars:Object = null):void;
		function cancelLooping():void;
		function getFrameByLabel(frame:String):int;
		function frameIsValid(frame:Object):Boolean;
		function parseFrame(frame:Object):int;
		function set onCompleteFrame(closure:Function):void;
		function set trackAsMenu(value:Boolean):void;
		function get trackAsMenu():Boolean;
		function get duration():Number;
		function get position():Number;
		function get currentLabels():Array;
		function get currentLabel():String;
		function get currentFrame():int;
		function get framesLoaded():int;
		function get totalFrames():int;
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
	}
}