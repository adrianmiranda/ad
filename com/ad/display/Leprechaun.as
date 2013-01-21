package com.ad.display {
	import com.ad.interfaces.IDisplay;
	import com.ad.utils.Cleaner;
	
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class Leprechaun extends Nymph implements IDisplay {
		private var _registrationPoint:Point;
		private var _registrationShape:Shape;
		private var _locked:Boolean;
		private var _dead:Boolean;
		
		public function Leprechaun() {
			super();
			this.moveRegistrationPoint(0, 0);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
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

		public function get parentScaleX():Number {
			return super.scaleX;
		}
		
		public function set parentScaleY(value:Number):void {
			this.setProperty('scaleY', value);
		}

		public function get parentScaleY():Number {
			return super.scaleY;
		}
		
		public function set parentRotation(value:Number):void {
			this.setProperty('rotation', value);
		}

		public function get parentRotation():Number {
			return super.rotation;
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
			value ? this.attachRegistrationPoint(5) : this.detachRegistrationPoint();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			var holder:DisplayObject;
			try {
				holder = super.addChild(child);
				super.dispatchEvent(new Event(Event.RESIZE));
			} catch(event:Error) {
				trace(this.toString() + 'addChild(' + event.message + ');');
			}
			return holder;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var holder:DisplayObject;
			try {
				holder = super.addChildAt(child, index);
				super.dispatchEvent(new Event(Event.RESIZE));
			} catch(event:Error) {
				trace(this.toString() + 'addChildAt(' + event.message, index + ');');
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
				this._registrationShape.graphics.beginFill(0xffffff, 1);
				this._registrationShape.graphics.lineStyle(2, 0xFF0000);
				this._registrationShape.graphics.moveTo(-diameter, -diameter);
				this._registrationShape.graphics.lineTo(diameter, diameter);
				this._registrationShape.graphics.moveTo(-diameter, diameter);
				this._registrationShape.graphics.lineTo(diameter, -diameter);
				this._registrationShape.graphics.drawCircle(0, 0, diameter * 2);
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
			return '[Leprechaun ' + super.name + ']';
		}

		/**
		 * IDisplay proxies
		 */
		public function gotoAndStop(frame:Object, scene:String = null):void {
			// never implement
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void {
			// never implement
		}

		public function prevFrame():void {
			// never implement
		}
		
		public function nextFrame():void {
			// never implement
		}
		
		public function nextScene():void {
			// never implement
		}
		
		public function prevScene():void {
			// never implement
		}
		
		public function stop():void {
			// never implement
		}
		
		public function play():void {
			// never implement
		}
		
		public function playTo(frame:Object, vars:Object = null):void {
			// never implement
		}
		
		public function playToBeginAndStop(vars:Object = null):void {
			// never implement
		}
		
		public function playToEndAndStop(vars:Object = null):void {
			// never implement
		}
		
		public function loopBetween(from:Object = 1, to:Object = 0, yoyo:Boolean = false, vars:Object = null):void {
			// never implement
		}
		
		public function cancelLooping():void {
			// never implement
		}
		
		public function set onCompleteFrame(closure:Function):void {
			// never implement
		}
		
		public function set trackAsMenu(value:Boolean):void {
			// never implement
		}
		
		public function set enabled(value:Boolean):void {
			// never implement
		}
		
		public function frameIsValid(frame:Object):Boolean {
			return !1;
		}
		
		public function get trackAsMenu():Boolean {
			return !1;
		}
		
		public function get enabled():Boolean {
			return !1;
		}
		
		public function getFrameByLabel(frame:String):int {
			return 0;
		}
		
		public function parseFrame(frame:Object):int {
			return 0;
		}
		
		public function get duration():Number {
			return 0;
		}
		
		public function get position():Number {
			return 0;
		}
		
		public function get currentFrame():int {
			return 0;
		}
		
		public function get framesLoaded():int {
			return 0;
		}
		
		public function get totalFrames():int{
			return 0;
		}
		
		public function get currentLabels():Array {
			return [];
		}
		
		public function get currentLabel():String {
			return '';
		}
	}
}