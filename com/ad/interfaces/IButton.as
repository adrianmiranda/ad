package com.ad.interfaces {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IButton extends IDisplay {
		function get params():Object;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get reference():uint;
		function set reference(value:uint):void;
		function active():void;
		function click():void;
		function over():void;
		function out():void;
	}
}