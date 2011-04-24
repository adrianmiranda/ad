﻿package com.ad.templates {
	import com.ad.display.Fairy;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class Base extends Fairy {
		private var _screen:Rectangle = new Rectangle();
		private var _flashVars:Object = new Object();
		private var _resizable:Boolean;
		
		public function Base(resizable:Boolean = false) {
			this._resizable = resizable;
			if (super.stage) this.onAddedToStage(null);
			else super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this._flashVars = super.stage.loaderInfo.parameters;
			this._screen.right = super.stage.stageWidth;
			this._screen.bottom = super.stage.stageHeight;
			this.initialize();
			if (this._resizable) {
				super.stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
				this.onStageResize(new Event(Event.RESIZE));
			}
		}
		
		protected function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			this.finalize();
			if (this._resizable) {
				super.stage.removeEventListener(Event.RESIZE, this.onStageResize);
			}
		}
		
		protected function onStageResize(event:Event):void {
			this._screen.top = 0;
			this._screen.left = 0;
			try {
				this._screen.right = super.stage.stageWidth;
				this._screen.bottom = super.stage.stageHeight;
			} catch (event:Error) {	
				this._screen.right = this._screen.right;
				this._screen.bottom = this._screen.bottom;
				trace(this.toString(), event.message);
			}
			this.arrange();
		}
		
		protected function initialize():void {
			// to override
		}
		
		protected function finalize():void {
			// to override
		}
		
		public function arrange():void {
			// to override
		}
		
		public function get screen():Rectangle {
			return this._screen.clone();
		}
		
		public function get flashVars():Object {
			return this._flashVars;
		}
		
		override public function toString():String {
			return '[Base ' + super.name + ']';
		}
	}
}