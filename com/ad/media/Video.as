package com.ad.media {
	import com.ad.common.num;
	import com.ad.common.clamp;
	import com.ad.data.CuePoint;
	import com.ad.events.MediaEvent;
	import com.ad.net.NetStreamExpert;

	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.media.Video;
	
	/**
	 * @tips To use video steps just player 10.1 or older and
	 * Export video with key frame distance: 1
	 */
	public class Video extends flash.media.Video {
		public static const MIN_SPEED:Number = 0.02;
		public static const MAX_SPEED:Number = 0.4;
		private var _stream:NetStreamExpert;
		private var _percentLoaded:Number = 0;
		private var _cuepoint:CuePoint;
		private var _duration:Number = 0;
		private var _frames:Number = 0;
		private var _speed:Number = 0;
		
		public function Video(videoURL:String):void {
			super.smoothing = true;
			this.connectVideo(videoURL);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeVideo);
		}
		
		private function connectVideo(url:String):void {
			this._stream = new NetStreamExpert();
			super.attachNetStream(this._stream);
			var client:Object = new Object();
			client.onMetaData = this.onMetaData;
			client.onCuePoint = this.onCuePoint;
			client.onXMPData = this.onXMPData;
			this._stream.client = client;
			this._stream.bufferTime = 0;
			this._stream.play(url);
			this._stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
			this._stream.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus);
			super.addEventListener(Event.ENTER_FRAME, this.updatePreloader);
		}
		
		public function play(uri:String = null):void {
			this._stream.play(uri);
		}
		
		public function pause():void {
			this._stream.pause();
		}
		
		public function resume():void {
			this._stream.resume();
		}
		
		public function stop():void {
			this._frames = 0;
			this._stream.stop();
		}
		
		public function close():void {
			this._frames = 0;
			this._stream.close();
		}
		
		public function seek(second:Number):void {
			this._stream.seek(clamp(num(second), 0, this._duration));
		}
		
		public function step(frame:Number, loop:Boolean = false):void {
			if (!this._stream.paused) {
				if (Math.abs(frame) >= MAX_SPEED) {
					frame = MAX_SPEED;
				}
				if (Math.abs(frame) <= MIN_SPEED) {
					frame = MIN_SPEED;
				}
				this._speed = frame;
				this._frames += this._speed;
				this.seek(Math.max(0, Math.min(this._frames, this._duration)));
				if (loop) {
					this.stepLoop();
				} else {
					if (this._frames < 0) {
						this._frames = 0;
					}
					if (this._frames > this._duration) {
						this._frames = this._duration;
					}
				}
			}
		}
		
		private function stepLoop():void {
			if (this._stream.time <= (Math.abs(this._speed))) {
				this._frames = this._duration - (Math.abs(this._speed) * 1.75) - 0.005;
			}
			if (this._stream.time > (this._duration) - (Math.abs(this._speed) * 1.75) - 0.05) {
				this._frames = (Math.abs(this._speed)) + 0.005;
			}
		}
		
		private function onAsyncError(event:AsyncErrorEvent):void {
			this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
		}
		
		private function onNetStatus(event:NetStatusEvent):void {
			switch (event.info.code) {
				case 'NetStream.Play.StreamNotFound':
					trace('Video file passed, not available!');
					break;
				case 'NetStream.Play.Stop':
				case 'NetStream.Play.Complete':
					if (Math.ceil(this._stream.time) >= Math.floor(this._duration)) {
						super.dispatchEvent(new MediaEvent(MediaEvent.COMPLETE, this, '', null));
					}
					break;
			}
		}
		
		private function onCuePoint(info:Object):void {
			trace('cuepoint: time=' + info.time + ' name=' + info.name + ' type=' + info.type);
			this._cuepoint = new CuePoint(info);
			super.dispatchEvent(new MediaEvent(MediaEvent.CUE_POINT, this, '', this._cuepoint));
		}
		
		private function onMetaData(info:Object):void {
			this._duration = info.duration;
		}
		
		private function onXMPData(info:Object):void {
			var onXMPXML:XML = new XML(info.data);
			trace(onXMPXML);
		}
		
		private function updatePreloader(event:Event):void {
			if (this._percentLoaded >= 100) {
				if (this._duration) {
					//this._stream.pause();
					super.dispatchEvent(new Event(Event.COMPLETE));
					this.removeEventListener(Event.ENTER_FRAME, this.updatePreloader);
				}
			} else {
				this._percentLoaded = this._stream.bytesPercent;
				super.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			}
		}
		
		private function removeVideo(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.removeVideo);
			this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
			this._stream.close();
			this._stream = null;
		}

		public function get position():Number {
			return Math.ceil(this.time);
		}
		
		public function get duration():Number {
			return Math.round(this.length);
		}

		public function get time():Number {
			return stream ? stream.time : 0;
		}

		public function get length():Number {
			return this._duration;
		}
		
		public function get speed():Number {
			return this._speed;
		}
		
		public function get paused():Boolean {
			return this._stream.paused;
		}
		
		public function get percentLoaded():Number {
			return this._percentLoaded;
		}
		
		public function get stream():NetStreamExpert {
			return this._stream;
		}
	}
}