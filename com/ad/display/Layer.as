package com.ad.display {
	import com.ad.display.Leprechaun;
	import com.ad.proxy.nsdisplay;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
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
		nsdisplay function setLocked(value:String):void {
			super.locked = (value == 'true' || value == '1' || value == 'yes' || value == 'y' || value == 'sim' || value == 's');
		}
		
		nsdisplay function set setShowRegistrationPoint(value:Boolean):void {
			super.setShowRegistrationPoint = (value == 'true' || value == '1' || value == 'yes' || value == 'y' || value == 'sim' || value == 's');
		}
		
		override public function toString():String {
			return '[Layer ' + super.name + ']';
		}
	}
}