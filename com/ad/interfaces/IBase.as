package com.ad.interfaces {
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IBase extends IViewer {
		function startRendering():void;
		function stopRendering():void;
		function get originBounds():Rectangle;
		function get screen():Rectangle;
		function arrange():void;
	}
}