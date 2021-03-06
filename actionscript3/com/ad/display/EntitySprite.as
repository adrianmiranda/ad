package com.ad.display {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class EntitySprite extends Sprite {
		
		public function EntitySprite() {
			super.focusRect = false;
			super.tabEnabled = false;
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
			return '[EntitySprite ' + super.name + ']';
		}
	}
}