package com.ad.interfaces {
	
	public interface IButton extends IDisplay {
		function get params():Object;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get reference():uint;
		function set reference(value:uint):void;
	}
}