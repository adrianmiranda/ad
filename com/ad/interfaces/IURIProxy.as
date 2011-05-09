package com.ad.interfaces {
	import flash.events.IEventDispatcher;
	
	public interface IURIProxy extends IEventDispatcher {
		function back():void;
		function forward():void;
		function up():void;
		function go(delta:int):void;
		function href(url:String, target:String = '_self'):void;
		function popup(url:String, name:String = 'popup', options:String = '""', handler:String = ''):void;
		function getBaseURL():String;
		function getStrict():Boolean;
		function setStrict(strict:Boolean):void;
		function getHistory():Boolean;
		function setHistory(history:Boolean):void;
		function getTracker():String;
		function setTracker(tracker:String):void;
		function getTitle():String;
		function setTitle(title:String):void;
		function getStatus():String;
		function setStatus(status:String):void;
		function resetStatus():void;
		function getValue():String;
		function setValue(value:String):void;
		function getPath():String;
		function getPathNames():Array;
		function getQueryString():String;
		function getParameter(param:String):Object;
		function getParameterNames():Array;
	}
}