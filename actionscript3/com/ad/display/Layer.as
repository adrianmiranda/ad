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
		
		public function moveForward(shapeToMove:DisplayObject):void {
			var shapeIndex:int = super.getChildIndex(shapeToMove);
			var destinationIndex:int = shapeIndex + 1;
			if (destinationIndex < super.numChildren) {
				var destination:DisplayObject = super.getChildAt(destinationIndex);
				super.swapChildren(shapeToMove, destination);
			}
		}
		
		public function moveToFront(shapeToMove:DisplayObject):void {
			super.setChildIndex(shapeToMove, super.numChildren - 1);
		}
		
		public function moveBackward(shapeToMove:DisplayObject):void {
			var shapeIndex:int = super.getChildIndex(shapeToMove);
			var destinationIndex:int = shapeIndex - 1;
			if (destinationIndex >= 0) {
				var destination:DisplayObject = super.getChildAt(destinationIndex);
				super.swapChildren(shapeToMove, destination);
			}
		}
		
		public function moveToBack(shapeToMove:DisplayObject):void {
			super.setChildIndex(shapeToMove, 0);
		}
		
		override public function toString():String {
			return '[Layer ' + super.name + ']';
		}
	}
}