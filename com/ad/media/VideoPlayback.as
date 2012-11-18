package com.ad.media {
	import com.ad.common.num;
	import com.ad.common.clamp;
	import com.ad.common.percentage;
	import com.ad.events.EventControl;
	import com.ad.net.NetStreamExpert;
	import com.ad.data.MetaData;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.media.Video;
	import flash.utils.Timer;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class VideoPlayback extends EventControl {
		public static const MIN_SPEED:Number = 0.02;
		public static const MAX_SPEED:Number = 0.4;
		public static const READY:String = 'VideoPlayback.READY';
		private var _videoSize:Point;
		private var _stream:NetStreamExpert;
		private var _stageVideo:VideoStage;
		private var _metadata:MetaData;
		private var _percentBytes:Number = 0;
		private var _frames:Number = 0;
		private var _speed:Number = 0;
		private var _video:Video;
		private var _timer:Timer;
		
		public function VideoPlayback(video:Video = null) {
			this._video = video;
			this._timer = new Timer(100, 0);
			this._stream = new NetStreamExpert();
			this._videoSize = new Point(video ? video.width : 320, video ? video.height : 240);
			this._stageVideo = new VideoStage(null, 0, 0, this._videoSize.x, this._videoSize.y, 0);
			this._stageVideo.addEventListener(VideoStage.READY, this.attachVideo);
		}
		
		private function attachVideo(event:Event):void {
			this._stageVideo.removeEventListener(VideoStage.READY, this.attachVideo);
			super.dispatchEvent(new Event(VideoPlayback.READY));
		}
		
		public function connectVideo(uri:String, bufferTime:Number = 0, autoPlay:Boolean = false):void {
			if (this._video) {
				this._video.attachNetStream(this._stream);
			} else if (this._stageVideo.available) {
				this._stageVideo.attachNetStream(this._stream);
				this._stageVideo.update();
			}
			
			var client:Object = new Object();
			client.onMetaData = this.onMetaData;
			this._stream.client = client;
			
			this._stream.bufferTime = bufferTime;
			this._stream.play(uri);
			if (!autoPlay) this._stream.pause();
			this._stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
			
			this._timer.addEventListener(TimerEvent.TIMER, this.onUpdatePreloader);
			this._timer.start();
		}
		
		private function onAsyncError(event:AsyncErrorEvent):void {
			this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
			trace('Async Error:' + event.text);
		}
		
		private function onUpdatePreloader(event:Event):void {
			if (this._metadata) {
				if (this._percentBytes >= 100) {
					if (this._metadata) {
						this._timer.reset();
						this._timer.removeEventListener(TimerEvent.TIMER, this.onUpdatePreloader);
						super.dispatchEvent(new Event(Event.COMPLETE));
					}
				} else {
					this._percentBytes = Math.floor((this._stream.bytesLoaded * 100) / this._stream.bytesTotal);
					super.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
				}
			}
		}
		
		public function play(uri:String = null):void {
			if (this._metadata) {
				this._stream.play(uri);
			}
		}
		
		public function pause():void {
			if (this._metadata) {
				this._stream.pause();
			}
		}
		
		public function resume():void {
			if (this._metadata) {
				this._stream.resume();
			}
		}
		
		public function stop():void {
			if (this._metadata) {
				this._stream.stop();
			}
		}
		
		public function togglePause():void {
			this._stream.paused ? this.resume() : this.pause();
		}
		
		public function close():void {
			this.stop();
			if (!this._stream.loaded) {
				this._stream.close();
			}
		}
		
		public function seek(second:Number):void {
			if (this._metadata) {
				this._stream.seek(clamp(num(second), 0, this._metadata.duration));
			}
		}
		
		public function seekPercent(percent:Number):void {
			if (this._metadata) {
				this.seek(clamp(percentage(percent, this._metadata.duration), 0, 1));
			}
		}
		
		public function stepFrames(frame:Number, loop:Boolean = false):void {
			if (Math.abs(frame) >= MAX_SPEED) {
				frame = MAX_SPEED;
			}
			if (Math.abs(frame) <= MIN_SPEED) {
				frame = MIN_SPEED;
			}
			
			this._speed = frame;
			this._frames += this._speed;
			
			this._stream.seek(this._frames);
			trace('frames:', this._frames);
			
			if (loop) {
				this.loopStepFrames();
			}
		}
		
		private function loopStepFrames():void {
			if (this._metadata) {
				if (this._stream.time <= (Math.abs(this._speed))) {
					this._frames = this._metadata.duration - (Math.abs(this._speed) * 1.75) - 0.005;
				}
				if (this._stream.time > (this._metadata.duration) - (Math.abs(this._speed) * 1.75) - 0.05) {
					this._frames = Math.abs(this._speed) + 0.005;
				}
			}
		}
		
		public function dispose():void {
			this._timer.removeEventListener(TimerEvent.TIMER, this.onUpdatePreloader);
			this._stageVideo.removeEventListener(VideoStage.READY, this.attachVideo);
			this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
			this._stream.dispose();
			this._timer.reset();
			this._timer = null
			this._stageVideo = null;
			this._stream = null;
			this._video = null;
		}
		
		private function onMetaData(info:Object):void {
			this._metadata = new MetaData(info);
		}
		
		public function get available():Boolean {
			return this.tv != null && this._metadata != null;
		}

		public function get defaultHeight():Number {
			return this._videoSize.y;
		}

		public function get defaultWidth():Number {
			return this._videoSize.x;
		}
		
		public function get tv():* {
			return this.video ? this.video : this.stageVideo;
		}
		
		public function get stageVideo():VideoStage {
			return this._stageVideo;
		}
		
		public function get video():Video {
			return this._video;
		}
		
		public function get progress():Number {
		    return this._metadata ? percentage(this._stream.time, this._metadata.duration) : 0;
		}
		
		public function get speed():Number {
			return this._speed;
		}
	}
}