package com.ad.interfaces {
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IViewer extends IDisplay {
		function transitionIn():void;
		function transitionOut():void;
		function transitionInComplete():void;
		function transitionOutComplete():void;
	}
}