package com.ad.media {
	import com.ad.interfaces.IMedia;
	import com.ad.display.Leprechaun;
	import com.ad.controls.MediaControl;
	import com.ad.controls.MasterEqualizer;
	import com.ad.data.EqualizeParse;
	import com.ad.proxy.nsmedia;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.URLRequest;
	import flash.net.NetStream;
	
	use namespace nsmedia;
	public class Video extends Leprechaun implements IMedia {
		protected var isLoaded:Boolean = false;
		protected var isPlaying:Boolean = false;
		protected var url:String;
		protected var video:flash.media.Video;
		protected var duration:Number;
		protected var netStream:NetStream;
		protected var currentPosition:Number = 0;
		protected var soundChannel:SoundChannel;
		protected var netConnection:NetConnection;
		
		public function Video(width:int = 320, height:int = 240) {
			super.graphics.beginFill(0, 0);
			super.graphics.drawRect(0, 0, width, height);
			super.graphics.endFill();
			this.video = new flash.media.Video(width, height);
			super.addChild(this.video);
			MediaControl.addMedia(this);
		}
		
		public function setBackground(color:uint, alpha:Number):void {
			super.graphics.clear();
			super.graphics.beginFill(color, alpha);
			super.graphics.drawRect(0, 0, super.width, super.height);
			super.graphics.endFill();
		}
		
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void {
			if (this.isLoaded) return;
			this.url = stream.url;
			this.netConnection = new NetConnection();
			this.netConnection.connect(null);
			this.isLoaded = true;
			this.netStream = new NetStream(this.netConnection);
			this.netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.nsErrorEventHandler);
			this.netStream.addEventListener(IOErrorEvent.IO_ERROR, this.nsStatusEventHandler);
			this.netStream.client = { onMetaData:this.onMetaData, onXMPData:this.onXMPData };
			this.video.attachNetStream(this.netStream);
			this.netStream.play(this.url);
			this.netStream.pause();
			this.netStream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			if (event.info.code == 'NetStream.Play.Stop' && this.netStream.time >= duration) {
				super.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function nsErrorEventHandler(event:AsyncErrorEvent):void {
			trace(this + event);
		}
		
		private function nsStatusEventHandler(event:NetStatusEvent):void
		{
			trace(this + event);
		}
		
		private function onMetaData(param:Object):void {
			duration = param.duration;
		}
		
		public function onXMPData(parameters:Object):void {
			// no yet implement
		}
		
		public function play(startTime:Number = -1, loops:int = 0, soundTransform:SoundTransform = null):SoundChannel {
			this.isPlaying = true;
			this.netStream.resume();
			if (startTime > -1) {
				this.netStream.seek(startTime);
			}
			this.netStream.soundTransform = sondTransform;
			this.soundChannel = new SoundChannel();
			this.soundChannel.soundTransform = this.netStream.soundTransform;
			this.update();
			return this.soundChannel;
		}
		
		public function pause():void {
			this.isPlaying = false;
			this.currentPosition = this.netStream.time;
			this.netStream.pause();
		}
		
		public function stop(close:Boolean = true):void {
			this.currentPosition = 0;
			if (this.isPlaying) this.netStream.pause();
			if (this.netStream.bytesLoaded != this.netStream.bytesTotal && close) this.netStream.close();
			this.isPlaying = false;
		}
		
		public function set volume(value:Number):void {
			var transform:SoundTransform = this.soundChannel.soundTransform;
			transform.volume = value;
			this.soundChannel.soundTransform = transform;
			this.update();
		}
		
		public function get volume():Number {
			return this.soundChannel.soundTransform.volume;
		}
		
		public function get position():Number {
			return this.netStream.time;
		}
		
		/** @private */
		nsmedia function update(equalizeParse:EqualizeParse = null):void {
			if (!this.soundChannel) return;
			equalizeParse = equalizeParse ? equalizeParse : MasterEqualizer.getInstance().equalize;
			var transform:SoundTransform = new SoundTransform(this.soundChannel.soundTransform.volume * equalizeParse.volume, this.soundChannel.soundTransform.pan * equalizeParse.pan);
			this.transform.leftToLeft = this.soundChannel.soundTransform.leftToLeft * equalizeParse.leftSpeak;
			this.transform.rightToRight = this.soundChannel.soundTransform.rightToRight * equalizeParse.rightSpeak;
			this.netStream.soundTransform = transform;
		}
	}
}