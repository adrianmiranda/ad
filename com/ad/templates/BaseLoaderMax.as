package com.ad.templates {
	import com.ad.interfaces.IBaseLoader;
	
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class BaseLoaderMax extends BaseMax implements IBaseLoader {
		private var _bytesLoaded:Number = 0;
		private var _bytesTotal:Number = 0;
		private var _startTime:Number = 0;
		private var _endTime:Number = 0;
		private var _loadTime:Number = 0;
		private var _kbps:Number = 0;
		private var _percentage:Number = 0;
		private var _progress:Number = 0;
		private var _secondsLeft:Number = 0;
		
		public function BaseLoaderMax(resizable:Boolean = false, autoStartRendering:Boolean = false, margin:Rectangle = null) {
			super(resizable, autoStartRendering, margin);
		}
		
		public function get bytesLoaded():Number {
			return this._bytesLoaded;
		}
		
		public function get bytesTotal():Number {
			return this._bytesTotal;
		}
		
		public function get percentage():uint {
			return this._percentage;
		}
		
		public function get progress():Number {
			return this._progress;
		}
		
		public function get loadTime():Number {
			return this._loadTime;
		}
		
		public function get secondsLeft():Number {
			return Math.floor(this._secondsLeft) / 60;
		}
		
		public function get kbps():Number {
			return Math.floor(this._kbps);
		}
		
		public function bytes(bytesLoaded:Number, bytesTotal:Number):void {
			this._bytesLoaded = bytesLoaded;
			this._bytesTotal = bytesTotal;
			this.open();
			this._progress = Math.max(0, Math.min(1, (this._bytesLoaded / this._bytesTotal)));
			this._percentage = Math.round(this._progress * 100);
			this.update();
		}
		
		public function fault(message:String):void {
			trace('FAULT:', message);
		}
		
		private function open():void {
			if (this._progress == 0) {
				this._endTime = 0;
				this._loadTime = 0;
				this._kbps = 0;
				this._startTime = getTimer();
			}
		}
		
		private function update():void {
			if (this._progress == 1) {
				this._endTime = getTimer();
				this._loadTime = (this._endTime - this._startTime) / 1000;
				this._kbps = (this._bytesLoaded / this._loadTime) / 1024;
			} else {
				this._secondsLeft = ((1 / this._progress) - 1) * this._startTime;
			}
		}
		
		override public function toString():String {
			return '[BaseLoaderMax ' + super.name + ']';
		}
	}
}