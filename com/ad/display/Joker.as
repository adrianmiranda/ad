package com.ad.display {
	import com.ad.interfaces.IMovieClip;
	
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.utils.Timer;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * @see http://gamedev.michaeljameswilliams.com/2009/04/03/extends-override-and-super/
	 * @see http://flash-creations.com/notes/actionscript_controlsound.php
	 */
	dynamic public class Joker extends Fairy implements IMovieClip {
		private var _movie:MovieClip;
		private var _vars:Object;
		private var _delayTimer:Timer;
		private var _targetFrame:uint;
		private var _targetNextFrame:uint;
		private var _hasEnterFrame:Boolean;
		private var _running:Boolean;
		private var _looping:Boolean;
		private var _yoyo:Boolean;
		
		public function Joker(target:MovieClip = null) {
			super();
			this._movie = target;
			this.stop();
			this.loopBetween();
		}
		
		override public function gotoAndStop(frame:Object, scene:String = null):void {
			this.removeDelay();
			this.removeEnterFrame();
			super.gotoAndStop(frame, scene);
			this._running = false;
		}
		
		override public function gotoAndPlay(frame:Object, scene:String = null):void {
			this.removeDelay();
			this.removeEnterFrame();
			super.gotoAndPlay(frame, scene);
			this._running = true;
		}
		
		override public function prevFrame():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.prevFrame();
			this._running = false;
		}
		
		override public function nextFrame():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.nextFrame();
			this._running = false;
		}
		
		override public function nextScene():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.nextScene();
			this._running = false;
		}
		
		override public function prevScene():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.prevScene();
			this._running = false;
		}
		
		override public function stop():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.stop();
			this._running = false;
		}
		
		override public function play():void {
			this.removeDelay();
			this.removeEnterFrame();
			super.play();
			this._running = true;
		}

		override public function addFrameScript(...rest:Array):void {
			super.addFrameScript.apply(super, rest);
		}

		public function removeFrameScript(frame:Object):void {
			this.addFrameScript(frame, null);
		}
		
		public function playTo(frame:Object, vars:Object = null):void {
			if (this.frameIsValid(frame)) {
				this._vars = vars ? vars : {};
				this._targetFrame = parseFrame(frame);
				if (this._vars.onInit) {
					this._vars.onInit.apply(null, this._vars.onInitParams);
				}
				this.addDelay(Number(this._vars.delay) || 0);
			}
		}
		
		public function playToBeginAndStop(vars:Object = null):void {
			this.removeDelay();
			this.removeEnterFrame();
			this.playTo(1, vars);
		}
		
		public function playToEndAndStop(vars:Object = null):void {
			this.removeDelay();
			this.removeEnterFrame();
			this.playTo(super.totalFrames, vars);
		}
		
		public function loopBetween(from:Object = 1, to:Object = 0, yoyo:Boolean = false, vars:Object = null):void {
			if (this.frameIsValid(from) && this.frameIsValid(to)) {
				this.gotoAndStop(from);
				this._looping = true;
				this._yoyo = yoyo;
				this._targetNextFrame = this.parseFrame(from);
				if (this.parseFrame(to) == 0) {
					to = super.totalFrames;
				}
				this.playTo(to, vars);
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
					return uint(frame) > 0 && uint(frame) <= super.totalFrames;
				} else {
					return this.getFrameByLabel(String(frame)) > -1;
				}
			}
			return false;
		}
		
		public function parseFrame(frame:Object):int {
			if (this.frameIsValid(frame)) {
				if (frame is uint) {
					return uint(frame);
				} else {
					return this.getFrameByLabel(String(frame));
				}
			}
			return -1;
		}

		public function get timeElapsedFrame():Number {
			return Math.abs(this._targetFrame - super.currentFrame) / super.stage.frameRate;
		}

		public function get duration():Number {
			return super.totalFrames / super.stage.frameRate;
		}
		
		public function get position():Number {
			return super.currentFrame / super.stage.frameRate;
		}
		
		public function set onCompleteFrame(closure:Function):void {
			this._vars = this._vars ? this._vars : {};
			this._vars.onComplete = closure;
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
		
		private function addDelay(delay:Number):void {
			this.removeDelay();
			this._running = true;
			this._delayTimer = new Timer(delay * 1000, 1);
			this._delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayTimerComplete);
			this._delayTimer.start();
		}
		
		private function removeDelay():void {
			if (!this._delayTimer) return;
			this._running = false;
			this._delayTimer.reset();
			this._delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayTimerComplete);
			this._delayTimer = null;
		}
		
		private function onDelayTimerComplete(event:TimerEvent):void {
			this.removeDelay();
			this.addEnterFrame();
			if (this._vars.onStart) {
				this._vars.onStart.apply(null, this._vars.onStartParams);
			}
		}
		
		private function onUpdateFrames(event:Event):void {
			if (this._vars.onUpdate) {
				this._vars.onUpdate.apply(null, this._vars.onUpdateParams);
			}
			if (this.currentFrame < this._targetFrame) {
				super.nextFrame();
			} else if (this.currentFrame > this._targetFrame) {
				super.prevFrame();
			} else if (super.currentFrame == this._targetFrame) {
				if (this._vars.onComplete) {
					this._vars.onComplete.apply(null, this._vars.onCompleteParams);
				}
				if (this._looping) {
					if (this._yoyo) {
						this.loopBetween(super.currentFrame, this._targetNextFrame, this._yoyo, this._vars);
					} else {
						this.loopBetween(this._targetNextFrame, super.currentFrame, this._yoyo, this._vars);
					}
					return;
				} else {
					this.removeEnterFrame();
				}
			}
		}

		public function setVolume(value:Number):void {
			super.soundTransform = new SoundTransform(value, 0);
		}

		public function getVolume():Number {
			return super.soundTransform.volume;
		}

		public function get running():Boolean {
			return this._running;
		}

		public function get target():MovieClip {
			return this._movie;
		}
		
		override public function toString():String {
			return '[Joker ' + super.name + ']';
		}
	}
}
