package com.ad.templates {
	import com.ad.interfaces.IBase;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class BaseLite extends ViewerLite implements IBase {
		private var _margin:Rectangle = new Rectangle();
		private var _resolution:Point = new Point();
		private var _screen:Rectangle = new Rectangle();
		private var _flashVars:Object = new Object();
		private var _autoStartRendering:Boolean;
		private var _rendering:Boolean;
		private var _resizable:Boolean;
		private var _frameRate:Number;// @see http://www.leebrimelow.com/?p=237
		private var _quality:String;
		public var SW:Number = 0;
		public var SH:Number = 0;
		public var CW:Number = 0;
		public var CH:Number = 0;
		
		public function BaseLite(resizable:Boolean = false, autoStartRendering:Boolean = false, margin:Rectangle = null) {
			this._resizable = resizable;
			this._autoStartRendering = autoStartRendering;
			if (margin) this._margin = margin;
			if (super.stage) this.onAddedToStage(null);
			else super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.stage.addEventListener(Event.DEACTIVATE, this.onDeactivate);
			super.stage.addEventListener(Event.ACTIVATE, this.onActivate);
			this._flashVars = super.stage.loaderInfo.parameters;
			this._resolution.x = Capabilities.screenResolutionX;
			this._resolution.y = Capabilities.screenResolutionY;
			this._screen.left = this._margin.x;
			this._screen.top = this._margin.y;
			this._screen.right = (super.stage.stageWidth - this._margin.width);
			this._screen.bottom = (super.stage.stageHeight - this._margin.height);
			this.SW = (super.stage.stageWidth);
			this.SH = (super.stage.stageHeight);
			this.CW = (super.stage.stageWidth >> 1);
			this.CH = (super.stage.stageHeight >> 1);
			if (this._resizable && super.stage) {
				super.stage.align = 'tl';
				super.stage.scaleMode = 'noScale';
			}
			this.initialize();
			this._frameRate = super.stage.frameRate;
			this._quality = super.stage.quality;
			this.startArrange();
			if (this._autoStartRendering) {
				this.startRendering();
			}
		}
		
		protected function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			super.stage.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
			super.stage.removeEventListener(Event.ACTIVATE, this.onActivate);
			this.finalize();
			this.stopRendering();
			super.die();
			this._margin = null;
			this._screen = null;
			this._resolution = null;
			for (var property:String in this._flashVars) {
				delete this._flashVars[property];
			}
			this.stopArrange();
		}
		
		protected function onActivate(event:Event):void {
			this.activate();
		}
		
		protected function onDeactivate(event:Event):void {
			this.deactivate();
		}
		
		protected function onStageResize(event:Event):void {
			try {
				this._screen.left = this._margin.x;
				this._screen.top = this._margin.y;
				this._screen.right = (super.stage.stageWidth - this._margin.width);
				this._screen.bottom = (super.stage.stageHeight - this._margin.height);
				this.SW = (super.stage.stageWidth);
				this.SH = (super.stage.stageHeight);
				this.CW = (super.stage.stageWidth >> 1);
				this.CH = (super.stage.stageHeight >> 1);
				this.arrange();
			} catch (event:Error) {
				trace('Warning:', this.toString() + '.onStageResize(', event.message, ');');
			}
		}
		
		protected function onRenderTick(event:Event):void {
			this.rendering();
		}
		
		protected function startRendering():void {
			if (!this._rendering) {
				this._rendering = true;
				super.addEventListener(Event.ENTER_FRAME, this.onRenderTick, false, 0, true);
			}
		}
		
		protected function stopRendering():void {
			if (this._rendering) {
				this._rendering = false;
				super.removeEventListener(Event.ENTER_FRAME, this.onRenderTick);
			}
		}

		protected function startArrange():void {
			if (this._resizable && super.stage) {
				super.stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
				this.onStageResize(new Event(Event.RESIZE));
			}
		}

		protected function stopArrange():void {
			if (this._resizable && super.stage) {
				super.stage.removeEventListener(Event.RESIZE, this.onStageResize);
			}
		}
		
		protected function initialize():void {
			// to override
		}
		
		protected function finalize():void {
			// to override
		}
		
		protected function activate():void {
			// to override
		}
		
		protected function deactivate():void {
			// to override
		}
		
		protected function rendering():void {
			// to override
		}
		
		public function arrange():void {
			// to override
		}
		
		public function get resolution():Point {
			return this._resolution.clone();
		}
		
		public function get screen():Rectangle {
			return this._screen.clone();
		}
		
		public function get flashVars():Object {
			return this._flashVars;
		}
		
		public function get defaultFrameRate():Number {
			return this._frameRate;
		}
		
		public function defaultQuality():void {
			if (super.stage) super.stage.quality = this._quality;
		}
		
		public function lowQuality():void {
			if (super.stage) super.stage.quality = 'low';
		}
		
		public function mediumQuality():void {
			if (super.stage) super.stage.quality = 'medium';
		}
		
		public function highQuality():void {
			if (super.stage) super.stage.quality = 'high';
		}
		
		public function bestQuality():void {
			if (super.stage) super.stage.quality = 'best';
		}
		
		override public function toString():String {
			return '[BaseLite ' + super.name + ']';
		}
	}
}