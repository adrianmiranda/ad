package com.ad.display {
	import com.ad.templates.SpriteBase;
	
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class DraggableSprite extends SpriteBase {
		private var _bounds:Rectangle;
		private var _offset:Point;
		
		public function DraggableSprite() {
			this._offset = new Point(0, 0);
		}
		
		override protected function initialize():void {
			super.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownThis);
		}
		
		override protected function finalize():void {
			super.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownThis);
		}
		
		private function onMouseDownThis(event:MouseEvent):void {
			this.click();
		}
		
		protected function click():void {
			this.drag(true, null);
		}
		
		public function drag(lockCenter:Boolean = false, rectangle:Rectangle = null):void {
			var point:Point;
			if (!lockCenter) {
				point = localToGlobal(new Point(mouseX, mouseY));
			} else {
				point = localToGlobal(new Point(0, 0));
			}
			this._offset.x = (point.x - x);
			this._offset.y = (point.y - y);
			this._bounds = rectangle;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, drop);
		}
		
		private function onDrag(event:MouseEvent):void {
			x = event.stageX - this._offset.x;
			y = event.stageY - this._offset.y;
			if (this._bounds != null) {
				if (x < this._bounds.left) {
					x = this._bounds.left;
				} else if (x > this._bounds.right) {
					x = this._bounds.right;
				}
				if (y < this._bounds.top) {
					y = this._bounds.top;
				} else if (y > this._bounds.bottom) {
					y = this._bounds.bottom;
				}
			}
			event.updateAfterEvent();
		}
		
		public function drop(event:MouseEvent = null):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, drop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDrag);
		}
	}
}