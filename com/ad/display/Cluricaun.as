package com.ad.display {
	import com.ad.interfaces.IDisplay;
	import com.ad.utils.Cleaner;
	
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	dynamic public class Cluricaun extends Joker implements IDisplay {
		private var _registrationPoint:Point;
		private var _locked:Boolean;
		private var _dead:Boolean;
		
		public function Cluricaun() {
			super();
			this.moveRegistrationPoint(0, 0);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
		}
		
		private function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			this._dead = true;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function moveRegistrationPoint(x:Number, y:Number):void {
			this._registrationPoint = new Point(x, y);
		}
		
		public function set parentX(value:Number):void {
			var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			super.x = super.x + (value - point.x);
		}
		
		public function get parentX():Number {
			var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			return point.x;
		}
		
		public function set parentY(value:Number):void {
			var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			super.y = super.y + (value - point.y);
		}
		
		public function get parentY():Number {
			var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			return point.y;
		}
		
		public function get parentMouseX():Number {
			return Math.round(super.mouseX - this._registrationPoint.x);
		}
		
		public function get parentMouseY():Number {
			return Math.round(super.mouseY - this._registrationPoint.y);
		}
		
		public function set parentScaleX(value:Number):void {
			this.setProperty('scaleX', value);
		}
		
		public function set parentScaleY(value:Number):void {
			this.setProperty('scaleY', value);
		}
		
		public function set parentRotation(value:Number):void {
			this.setProperty('rotation', value);
		}
		
		private function setProperty(property:String, value:Number):void {
			var pointA:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			super[property] = value;
			var pointB:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
			super.x = super.x - (pointB.x - pointA.x);
			super.y = super.y - (pointB.y - pointA.y);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function move(x:Number, y:Number):void {
			super.x = Math.round(x);
			super.y = Math.round(y);
		}
		
		public function size(width:Number, height:Number):void {
			super.width = width;
			super.height = height;
		}
		
		public function set scale(value:Number):void {
			super.scaleX = super.scaleY = value;
		}
		
		public function fit(width:Number, height:Number):void {
			super.width = width;
			super.scaleY = super.scaleX;
			if (super.height < height) {
				super.height = height;
				super.scaleX = super.scaleY;
			}
		}
		
		public function set locked(value:Boolean):void {
			this._locked = value;
			super.mouseEnabled = !value;
			super.mouseChildren = !value;
			super.tabEnabled = !value;
			super.doubleClickEnabled = !value;
			if (super.stage) {
				super.stage.mouseChildren = !value;
			}
		}
		
		public function get locked():Boolean {
			return this._locked;
		}
		
		public function set showRegistrationPoint(value:Boolean):void {
			super.graphics.clear();
			if (!value) return;
			super.graphics.lineStyle(2, 0xFF0000);
			super.graphics.moveTo(-5, -5);
			super.graphics.lineTo(5, 5);
			super.graphics.moveTo(-5, 5);
			super.graphics.lineTo(5, -5);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			var holder:DisplayObject;
			try {
				holder = super.addChild(child);
				super.dispatchEvent(new Event(Event.RESIZE));
			} catch(event:Error) {
				trace(this.toString(), event.message);
			}
			return holder;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var holder:DisplayObject;
			try {
				holder = super.addChildAt(child, index);
				super.dispatchEvent(new Event(Event.RESIZE));
			} catch(event:Error) {
				trace(this.toString() + '.addChildAt(', index, event.message, ');');
			}
			return holder;
		}
		
		public function removeAllChildren(target:DisplayObjectContainer = null):void {
			Cleaner.removeChildrenOf(target || super);
		}
		
		public function die():void {
			if (!this._dead) {
				super.removeAllEventListener();
				Cleaner.kill(super);
				this._dead = true;
			}
		}
		
		override public function toString():String {
			return '[Cluricaun ' + super.name + ']';
		}
	}
}
