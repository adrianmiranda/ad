package com.ad.interfaces {
	import flash.geom.Rectangle;
	
	public interface IBase extends IViewer {
		function get screen():Rectangle;
		function arrange():void;
	}
}