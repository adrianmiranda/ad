package com.ad.interfaces {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IViewer extends IDisplay {
		function transitionIn():void;
		function transitionOut():void;
		function transitionInComplete():void;
		function transitionOutComplete():void;
	}
}