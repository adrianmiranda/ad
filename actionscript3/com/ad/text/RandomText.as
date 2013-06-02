﻿package com.ad.text {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class RandomText extends EventDispatcher {
		public static const DONE:String = 'done';
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		public static const CENTER:String = 'center';
		private var _dispose:Boolean;
		private var _autoDispose:Boolean;
		private var _textField:TextField;
		private var _align:String;
		private var _sourceText:String;
		private var _targetText:String;
		private var _setTextString:String;
		private var _setCount:uint;
		private var _randomText:String;
		private var _randomNum:Number;
		private var _slotTimer:Timer;
		private var _timer:Timer;
		private var _delayTimer:Timer;
		private var _onUpdate:Function;
		private var _onUpdateParams:Array;
		private var _onComplete:Function;
		private var _onCompleteParams:Array;
		
		public function RandomText(textField:TextField, delay:Number = 35, slotTime:Number = 1.5, autoDispose:Boolean = false) {
			this._dispose = true;
			this._autoDispose = autoDispose;
			this._textField = textField;
			this._sourceText = '_/-=+%&$#!?ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
			this._setTextString = '';
			this._timer = new Timer(delay);
			this._slotTimer = new Timer(slotTime);
			this._delayTimer = new Timer(0, 1);
			this._slotTimer.addEventListener(TimerEvent.TIMER, this.onRandomize, false, 0, true);
			this._timer.addEventListener(TimerEvent.TIMER, this.setText, false, 0, true);
			this._delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.timeCheck, false, 0, true);
		}
		
		public function randomize(textValue:String, delay:Number = 0, align:String = 'left'):void {
			if (this._dispose) {
				this._align = align;
				this._setTextString = '';
				this._targetText = textValue || '\^&$%!@#';
				this._randomText = '';
				this._randomNum = this._targetText.length;	
				this._setCount = 0;
				if (delay == 0) {
					this._timer.start();
					this._slotTimer.start();
				} else {
					this._delayTimer.delay = delay * 1000;
					this._delayTimer.start();
				}
			}
		}
		
		private function timeCheck(event:TimerEvent):void {
			this._timer.start();
			this._slotTimer.start();
		}
		
		private function setText(event:TimerEvent):void {
			this._randomNum--;
			switch (this._align) {
				case LEFT:
					if (this._targetText != '\^&$%!@#') {
						this._setTextString = this._setTextString + this._targetText.charAt(this._setCount - 1);
					}
					break;
				case RIGHT:
					if (this._targetText != '\^&$%!@#') {
						this._setTextString = this._targetText.charAt(this._targetText.length - this._setCount) + this._setTextString;
					}
					break;
				case CENTER:
					// no yet implemented
					break;
				default:
					// no yet implemented
					break;
			}
			this._textField.text = this._setTextString;
			this._setCount++;
			
			if (this._onUpdate != null) {
				this._onUpdateParams
			}
		}
		
		private function onRandomize(event:TimerEvent):void {
			this._randomText = '';
			var id:uint = 0;
			while (id < (this._randomNum + 1)) {
				this._randomText = this._randomText + this._sourceText.charAt(Math.floor(Math.random() * this._sourceText.length));
				id++;
			}
			switch (this._align) {
				case LEFT:
					this._textField.text = this._setTextString + this._randomText;
					break;
				case RIGHT:
					this._textField.text = this._randomText + this._setTextString;
					break;
				case CENTER:
					// no yet implemented
					break;
				default:
					// no yet implemented
					break;
			}
			if (this._setTextString == this._targetText) {
				super.dispatchEvent(new Event(DONE));
				this._slotTimer.stop();
				this._timer.stop();
				if (this._autoDispose) {
					this.die();
				}
			}
		}
		
		public function set onUpdate(closure:Function):void {
			this._onUpdate = closure;
		}
		
		public function set onUpdateParams(params:Array):void {
			this._onUpdateParams = params;
		}
		
		public function set onComplete(closure:Function):void {
			this._onComplete = closure;
		}
		
		public function set onCompleteParams(params:Array):void {
			this._onCompleteParams = params;
		}
		
		public function get textField():TextField {
			return this._textField;
		}
		
		public function get text():String {
			return this._targetText || '';
		}
		
		public function die(killTextField:Boolean = false):void {
			if (this._dispose) {
				this._dispose = false;
				this._slotTimer.removeEventListener(TimerEvent.TIMER, this.onRandomize, false);
				this._timer.removeEventListener(TimerEvent.TIMER, this.setText, false);
				this._delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.timeCheck, false);
				this._slotTimer = null;
				this._timer = null;
				this._delayTimer = null;
				this._sourceText = null;
				this._targetText = null;
				this._setCount = 0;
				this._setTextString = null;
				this._align = null;
				this._randomText = null;
				this._randomNum = 0;
				if (killTextField && this._textField && this._textField.stage) {
					this._textField.parent.removeChild(this._textField);
				}
				this._textField = null;
			}
		}
	}
}