package com.ad.interfaces {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IDisplay extends IMovieClip {
		function move(x:Number, y:Number):void;
		function size(width:Number, height:Number):void;
		function fit(width:Number, height:Number):void;
		function get locked():Boolean;
		function set scale(value:Number):void;
		function set locked(value:Boolean):void;
		function set showRegistrationPoint(value:Boolean):void;
		function moveRegistrationPoint(x:Number, y:Number):void;
		function removeAllChildren(target:DisplayObjectContainer = null):void;
		function die():void;
		function toString():String;
	}
}