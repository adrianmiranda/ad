package com.ad.display {
	import flash.events.Event;
	
	dynamic public class Joker extends EntityMovieClip {
		private var _vars:Object;
		private var _targetFrame:uint;
		private var _targetNextFrame:uint;
		private var _hasEnterFrame:Boolean;
		private var _looping:Boolean;
		private var _yoyo:Boolean;
		
		public function Joker() {
			this.stop();
			this.loopBetween();
		}
		
		override public function gotoAndStop(frame:Object, scene:String = null):void {
			this.removeEnterFrame();
			super.gotoAndStop(frame, scene);
		}
		
		override public function gotoAndPlay(frame:Object, scene:String = null):void {
			this.removeEnterFrame();
			super.gotoAndPlay(frame, scene);
		}
		
		override public function prevFrame():void {
			this.removeEnterFrame();
			super.prevFrame();
		}
		
		override public function nextFrame():void {
			this.removeEnterFrame();
			super.nextFrame();
		}
		
		override public function nextScene():void {
			this.removeEnterFrame();
			super.nextScene();
		}
		
		override public function prevScene():void {
			this.removeEnterFrame();
			super.prevScene();
		}
		
		override public function stop():void {
			this.removeEnterFrame();
			super.stop();
		}
		
		override public function play():void {
			this.removeEnterFrame();
			super.play();
		}
		
		public function playTo(frame:Object, vars:Object = null, scene:String = null):void {
			if (this.frameIsValid(frame)) {
				this._vars = vars ? vars : {};
				this._delay = Number(this.vars.delay) || 0; // no yet implement
				this._targetFrame = parseFrame(frame);
				this.addEnterFrame();
				if (this.vars.onStart) {
					this.vars.onStart.apply(null, this.vars.onStartParams);
				}
			}
		}
		
		public function playToBeginAndStop(vars:Object = null):void {
			this.removeEnterFrame();
			this.playTo(1, vars);
		}
		
		public function playToEndAndStop(vars:Object = null):void {
			this.removeEnterFrame();
			this.playTo(super.totalFrames, vars);
		}
		
		public function loopBetween(from:Object = 1, to:Object = 0, yoyo:Boolean = false):void {
			if (this.frameIsValid(from) && this.frameIsValid(to)) {
				this.gotoAndStop(from);
				this._looping = true;
				this._yoyo = yoyo;
				this._targetNextFrame = parseFrame(from);
				if (parseFrame(to) == 1) {
					to = super.totalFrames;
				}
				this.playTo(to);
			}
		}
		
		public function cancelLooping():void {
			this._looping = false;
			this._yoyo = false;
		}
		
		public function getFrameByLabel(frame:String):int {
			var frameLabel:FrameLabel;
			for each (frameLabel in super.currentLabels) {
				if (frameLabel.name === frame) {
					return frameLabel.frame;
				}
			}
			return -1;
		}
		
		public function frameIsValid(frame:Object):Boolean {
			if (frame is uint || frame is String) {
				if (frame is uint) {
					return frame > 0 && frame <= super.totalFrames;
				} else {
					return this.getFrameByLabel(frame) > -1;
				}
			}
			return false;
		}
		
		public function parseFrame(frame:Object):int {
			if (this.frameIsValid(frame)) {
				if (frame is uint) {
					return frame;
				} else {
					return this.getFrameByLabel(frame);
				}
			}
			return -1;
		}
		
		public function get timeTotalFrames():Number {
			return Math.abs(super.totalFrames - super.currentFrame) / super.stage.frameRate;
		}
		
		public function get timeCurrentFrame():Number {
			return Math.abs(this._targetFrame - super.currentFrame) / super.stage.frameRate;
		}
		
		private function addEnterFrame():void {
			if (this._hasEnterFrame) return;
			this._hasEnterFrame = true;
			super.addEventListener(Event.ENTER_FRAME, this.onUpdateFrames);
		}
		
		private function removeEnterFrame():void {
			if (!this._hasEnterFrame) return;
			this._hasEnterFrame = false;
			this._looping = false;
			this._yoyo = false;
			super.removeEventListener(Event.ENTER_FRAME, this.onUpdateFrames);
		}
		
		private function onUpdateFrames(evt:Event):void {
			if (this.vars.onUpdate) {
				this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
			}
			if (this.currentFrame < this._targetFrame) {
				super.nextFrame();
			} else if (this.currentFrame > this._targetFrame) {
				super.prevFrame();
			} else if (super.currentFrame == this._targetFrame) {
				if (this._looping) {
					if (this._yoyo) {
						this.loopBetween(super.currentFrame, this._targetNextFrame, this._yoyo);
					} else {
						this.loopBetween(this._targetNextFrame, super.currentFrame, this._yoyo);
					}
					return;
				} else {
					this.removeEnterFrame();
					if (this.vars.onComplete) {
						this.vars.onComplete.apply(null, this.vars.onCompleteParams);
					}
				}
			}
		}
	}
}