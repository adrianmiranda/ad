package com.ad.interfaces {
	
	public interface IViewer extends IDisplay {
		function transitionIn():void;
		function transitionOut():void;
		function transitionInComplete():void;
		function transitionOutComplete():void;
	}
}