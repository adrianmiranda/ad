package com.ad.display {
	import com.ad.utils.Cleaner;
	
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Leprechaun extends Sprite {
		private var _locked:Boolean = true;
		private var _dead:Boolean;
		
		public function Leprechaun() {
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
		}
		
		private function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			this._dead = true;
		}
		
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
		
		public function set locked(value:Boolean):void {
			this._locked = value;
			super.mouseEnabled = super.mouseChildren = super.tabEnabled  = super.doubleClickEnabled = !value;
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
		
		public function removeAllChildren():void {
			Cleaner.removeAllChildrenOf(super);
		}
		
		public function die():void {
			if (!this._dead) {
				Cleaner.kill(super);
				this._dead = true;
			}
		}
		
		override public function toString():String {
			return '[Leprechaun ' + super.name + ']';
		}
	}
}