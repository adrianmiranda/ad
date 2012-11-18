package com.ad.interfaces {
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public interface IBase extends IViewer {
		function get screen():Rectangle;
		function arrange():void;
	}
}