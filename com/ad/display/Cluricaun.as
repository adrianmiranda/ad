package com.ad.display {
	import com.ad.interfaces.IDisplay;
	import com.ad.utils.Cleaner;
	
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > FIXME: Interface hierarchy to implements.
	 */
	dynamic public class Cluricaun extends Joker implements IDisplay/*, IMovieClip*/ {
		private var _registrationPoint:Point;
		private var _registrationShape:Shape;
		private var _locked:Boolean;
		private var _dead:Boolean;
		
		public function Cluricaun() {
			super();
			this.moveRegistrationPoint(0, 0);
			super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false, 0, true);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
		}

		private function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false);
			this.rotation = super.rotation;
			this.scaleX = super.scaleX;
			this.scaleY = super.scaleY;
			this.x = super.x;
			this.y = super.y;
		}

		private function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			this.detachRegistrationPoint();
			this._dead = true;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function moveRegistrationPoint(x:Number, y:Number):void {
			this._registrationPoint = new Point(x, y);
			if (this._registrationShape) {
				this._registrationShape.x = x;
				this._registrationShape.y = y;
			}
		}
		
		override public function set x(value:Number):void {
			if (super.parent) {
				var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				super.x = super.x + (value - point.x);
			} else {
				super.x = value;
			}
		}
		
		override public function get x():Number {
			if (super.parent) {
				var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				return point.x;
			}
			return super.x;
		}
		
		override public function set y(value:Number):void {
			if (super.parent) {
				var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				super.y = super.y + (value - point.y);
			} else {
				super.y = value;
			}
		}
		
		override public function get y():Number {
			if (super.parent) {
				var point:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				return point.y;
			}
			return super.y;
		}
		
		override public function get mouseX():Number {
			return Math.round(super.mouseX - this._registrationPoint.x);
		}
		
		override public function get mouseY():Number {
			return Math.round(super.mouseY - this._registrationPoint.y);
		}
		
		override public function set scaleX(value:Number):void {
			this.setProperty('scaleX', value);
		}
		
		override public function set scaleY(value:Number):void {
			this.setProperty('scaleY', value);
		}
		
		override public function set rotation(value:Number):void {
			this.setProperty('rotation', value);
		}

		// in test
		override public function set rotationX(value:Number):void {
			this.setProperty('rotationX', value);
		}

		// in test
		override public function set rotationY(value:Number):void {
			this.setProperty('rotationY', value);
		}
		
		private function setProperty(property:String, value:Number):void {
			if (super.parent) {
				var pointA:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				super[property] = value;
				var pointB:Point = super.parent.globalToLocal(super.localToGlobal(this._registrationPoint));
				super.x = super.x - (pointB.x - pointA.x);
				super.y = super.y - (pointB.y - pointA.y);
			} else {
				super[property] = value;
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function move(x:Number, y:Number):void {
			this.x = Math.round(x);
			this.y = Math.round(y);
		}
		
		public function size(width:Number, height:Number):void {
			super.width = width;
			super.height = height;
		}
		
		public function set scale(value:Number):void {
			this.scaleX = this.scaleY = value;
		}
		
		public function fit(width:Number, height:Number):void {
			if (super.height < super.width) {
				super.height = height;
				this.scaleX = this.scaleY;
				if (super.width < width) {
					super.width = width;
					this.scaleY = this.scaleX;
				}
			} else {
				super.width = width;
				this.scaleY = this.scaleX;
				if (super.height < height) {
					super.height = height;
					this.scaleX = this.scaleY;
				}
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
			value ? this.attachRegistrationPoint(5) : this.detachRegistrationPoint();
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

		private function attachRegistrationPoint(diameter:Number = 5):void {
			this.detachRegistrationPoint();
			this._registrationShape = this.addChild(new Shape()) as Shape;
			if (this._registrationShape) {
				this._registrationShape.graphics.beginFill(0x00CCFF, 1);
				this._registrationShape.graphics.lineStyle(2, 0xFF0000);
				this._registrationShape.graphics.moveTo(-diameter, -diameter);
				this._registrationShape.graphics.lineTo(diameter, diameter);
				this._registrationShape.graphics.moveTo(-diameter, diameter);
				this._registrationShape.graphics.lineTo(diameter, -diameter);
				this._registrationShape.graphics.endFill();
				super.setChildIndex(this._registrationShape, super.numChildren - 1);
			}
		}

		private function detachRegistrationPoint():void {
			if (this._registrationShape) {
				this._registrationShape.graphics.clear();
				if (this._registrationShape.parent) {
					this._registrationShape.parent.removeChild(this._registrationShape);
					this._registrationShape = null;
				}
			}
		}

		override public function toString():String {
			return '[Cluricaun ' + super.name + ']';
		}
	}
}
