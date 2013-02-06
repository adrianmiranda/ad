package com.ad.templates {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 > FIXME: Interface hierarchy to implements.
	 */
	public class BaseNano extends Sprite /*implements IBase, ISprite*/ {
		private var _bounds:Rectangle = new Rectangle();
		private var _margin:Rectangle = new Rectangle();
		private var _screen:Rectangle = new Rectangle();
		private var _autoStartRendering:Boolean;
		private var _resizable:Boolean;
		
		public function BaseNano(resizable:Boolean = false, autoStartRendering:Boolean = false, margin:Rectangle = null) {
			this._resizable = resizable;
			this._autoStartRendering = autoStartRendering;
			if (margin) this._margin = margin;
			if (super.stage) this.onAddedToStage(null);
			else super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this._bounds = super.getBounds(super);
			this._screen.left = this._margin.x;
			this._screen.top = this._margin.y;
			this._screen.right = (super.stage.stageWidth - this._margin.width);
			this._screen.bottom = (super.stage.stageHeight - this._margin.height);
			if (this._resizable && super.stage) {
				super.stage.align = 'tl';
				super.stage.scaleMode = 'noScale';
			}
			this.initialize();
			this.startArrange();
			if (this._autoStartRendering) {
				this.startRendering();
			}
		}
		
		protected function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			this.finalize();
			this.stopRendering();
			this._margin = null;
			this._screen = null;
			stopArrange();
		}
		
		protected function onStageResize(event:Event):void {
			try {
				this._screen.left = this._margin.x;
				this._screen.top = this._margin.y;
				this._screen.right = (super.stage.stageWidth - this._margin.width);
				this._screen.bottom = (super.stage.stageHeight - this._margin.height);
				this.arrange();
			} catch (event:Error) {
				trace('Warning:', this.toString() + '.onStageResize(', event.message, ');');
			}
		}
		
		protected function onRenderTick(event:Event):void {
			this.rendering();
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
		
		protected function rendering():void {
			// to override
		}
		
		public function arrange():void {
			// to override
		}
		
		public function get originBounds():Rectangle {
			return this._bounds.clone();
		}

		public function get screen():Rectangle {
			return this._screen.clone();
		}
		
		public function get flashVars():Object {
			if (!super.stage) return {};
			return super.stage.loaderInfo.parameters;
		}
		
		override public function toString():String {
			return '[BaseNano ' + super.name + ']';
		}
	}
}