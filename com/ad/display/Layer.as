package com.ad.display {
	import com.ad.display.Leprechaun;
	import com.ad.proxy.nsdisplay;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Layer extends Leprechaun {
		private var _node:XML;
		
		public function Layer() {
			super();
		}
		
		/** @private */
		nsdisplay function setNode(node:XML):void {
			this._node = node;
		}
		
		/** @private */
		nsdisplay function getNode():XML {
			return this._node;
		}
		
		public function get(value:Object):DisplayObject {
			var child:DisplayObject;
			if (value is String) child = super.getChildByName(String(value));
			else if (value is int) child = super.getChildAt(int(value));
			return child;
		}
		
		override public function toString():String {
			return '[Layer ' + super.name + ']';
		}
	}
}