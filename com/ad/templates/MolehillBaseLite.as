package com.ad.templates {
	import com.ad.interfaces.IBase;
	
	import flash.geom.Matrix3D;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3D;
	import flash.display.Stage3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class MolehillBaseLite extends ViewerLite implements IBase {
		private var _margin:Rectangle = new Rectangle();
		private var _resolution:Point = new Point();
		private var _screen:Rectangle = new Rectangle();
		private var _flashVars:Object = new Object();
		private var _autoStartRendering:Boolean;
		private var _context3D:Context3D;
		private var _matrix3D:Matrix3D;
		private var _stage3D:Stage3D;
		private var _resizable:Boolean;
		private var _quality:String;
		public var SW:Number = 0;
		public var SH:Number = 0;
		public var CW:Number = 0;
		public var CH:Number = 0;
		
		public function MolehillBaseLite(resizable:Boolean = false, autoStartRendering:Boolean = false, margin:Rectangle = null) {
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
				super.stage.align = StageAlign.TOP_LEFT;
				super.stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			this._quality = super.stage.quality;
			this.createStage3D();
		}
		
		protected function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
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
			super.stage.removeEventListener(Event.ACTIVATE, this.onActivate);
			this.activate();
		}
		
		protected function onDeactivate(event:Event):void {
			super.stage.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
			this.deactivate();
		}
		
		private function createStage3D():void {
			var stage3DAvailable:Boolean = super.stage.hasOwnProperty('stage3Ds');
			if (stage3DAvailable) {
				this._stage3D = super.stage.stage3Ds[0];
				this._stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContext3DCreate);
				this._stage3D.addEventListener(ErrorEvent.ERROR, this.onStage3DError);
				this._stage3D.requestContext3D(Context3DRenderMode.AUTO);
			} else {
				trace('Flash 11 Required.\nYour version: ' + Capabilities.version);
			}
		}
		
		private function onContext3DCreate(event:Event):void {
			this._stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContext3DCreate);
			this.stopRendering();
			this._context3D = this._stage3D.context3D;
			if (!this._context3D) {
				trace('ERROR: Currently no 3D context is available - Video driver problem?');
				return;
			}
			if ((this._context3D.driverInfo == Context3DRenderMode.SOFTWARE) || (this._context3D.driverInfo.toLowerCase().indexOf('software') > -1)) {
				trace('Software Rendering Detected!\nYour Flash 11 settings\nhave hardware 3D turned OFF.\nIs wmode=direct in the html?\nExpect poor performance.');
			}
			
			this._context3D.enableErrorChecking = false;
			//--
			this._stage3D.x = this._screen.x;
			this._stage3D.y = this._screen.y;
			this._context3D.configureBackBuffer(this._screen.width, this._screen.height, 0, true);
			this._matrix3D = new Matrix3D();
			this._matrix3D.appendTranslation(0 - (this._screen.width >> 1), 0 - (this._screen.height >> 1), 0);
			this._matrix3D.appendScale((this._screen.width >> 1), 0 - (this._screen.height >> 1), 1);
			//--
			this.initialize();
			this.startArrange();
			if (this._autoStartRendering) {
				this.startRendering();
			}
		}
		
		private function onStage3DError(event:ErrorEvent):void {
			this._stage3D.removeEventListener(ErrorEvent.ERROR, this.onStage3DError);
			trace('Embed Error Detected!\nYour Flash 11 settings\nhave hardware 3D turned OFF.\nIs wmode=direct in the html?\nExpect poor performance.');
		}
		
		protected function onStageResize(event:Event):void {
			this._screen.left = this._margin.x;
			this._screen.top = this._margin.y;
			try {
				this._screen.right = (super.stage.stageWidth - this._margin.width);
				this._screen.bottom = (super.stage.stageHeight - this._margin.height);
				this.SW = (super.stage.stageWidth);
				this.SH = (super.stage.stageHeight);
				this.CW = (super.stage.stageWidth >> 1);
				this.CH = (super.stage.stageHeight >> 1);
				//--
				this._stage3D.x = this._screen.x;
				this._stage3D.y = this._screen.y;
				this._context3D.configureBackBuffer(this._screen.width, this._screen.height, 0, true);
				this._matrix3D = new Matrix3D();
				this._matrix3D.appendTranslation(0 - (this._screen.width >> 1), 0 - (this._screen.height >> 1), 0);
				this._matrix3D.appendScale((this._screen.width >> 1), 0 - (this._screen.height >> 1), 1);
				//--
			} catch (event:Error) {
				trace('Warning:', this.toString(), event.message);
			}
			this.arrange();
		}
		
		protected function onRenderTick(event:Event):void {
			try {
				this.rendering();
				this._context3D.present();
			} catch (error:Error) {
				trace('Rendering Error:', error.message);
			}
		}
		
		public function startRendering():void {
			super.addEventListener(Event.ENTER_FRAME, this.onRenderTick, false, 0, true);
		}
		
		public function stopRendering():void {
			super.removeEventListener(Event.ENTER_FRAME, this.onRenderTick);
		}

		public function startArrange():void {
			if (this._resizable && super.stage) {
				super.stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
				this.onStageResize(new Event(Event.RESIZE));
			}
		}

		public function stopArrange():void {
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
		
		public function get stage3D():Stage3D {
			return this._stage3D;
		}
		
		public function get context3D():Context3D {
			return this._context3D;
		}
		
		public function get modelMatrix():Matrix3D {
			return this._matrix3D;
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
			return '[MolehillBaseLite ' + super.name + ']';
		}
	}
}