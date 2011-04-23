package com.ad.media {
	import com.ad.interfaces.IMedia;
	import com.ad.controls.MediaControl;
	import com.ad.controls.MasterEqualizer;
	import com.ad.data.EqualizeParse;
	import com.ad.proxy.nsmedia;
	
	import flash.events.Event;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	use namespace nsmedia;
	public class Sound extends flash.media.Sound implements IMedia {
		protected var soundChannel:SoundChannel;
		protected var soundTransform:SoundTransform;
		protected var currentPosition:Number = 0;
		protected var isPlaying:Boolean = false;
		protected var isLoaded:Boolean = false;
		
		public function Sound() {
			MediaControl.addMedia(this);
		}
		
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void {
			if (this.isLoaded) return;
			super.load(stream, context);
			if (stream) this.isLoaded = true;
		}
		
		public function play(startTime:Number = -1, loops:int = 0, soundTransform:SoundTransform = null):SoundChannel {
			if (this.isPlaying) this.stop();
			this.isPlaying = true;
			if (this.soundChannel) this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
			this.soundChannel = super.play(startTime == -1 ? this.currentPosition : startTime, loops, soundTransform);
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
			soundTransform = soundTransform || this.soundTransform || this.soundChannel.soundTransform;
			this.update();
			return this.soundChannel;
		}
		
		public function onSoundComplete(evt:Event):void {
			super.dispatchEvent(evt.clone());
		}
		
		public function pause():void {
			this.isPlaying = false;
			this.currentPosition = this.soundChannel.position;
			this.soundChannel.stop();
		}
		
		public function stop(close:Boolean = true):void {
			this.currentPosition = 0;
			if (this.isPlaying) this.soundChannel.stop();
			if (super.bytesLoaded != super.bytesTotal && close) super.close();
			this.isPlaying = false;
		}
		
		public function get volume():Number {
			return this.soundTransform.volume;
		}
		
		public function get position():Number {
			return this.soundChannel.position;
		}
		
		public function get duration():Number {
			return super.length;
		}
		
		public function set volume(value:Number):void {
			var transform:SoundTransform = this.soundTransform;
			transform.volume = value;
			this.soundTransform = transform;
			this.update();
		}
		
		public function get playing():Boolean {
			return this.isPlaying;
		}
		
		/** @private */
		nsmedia function update(equalizeParse:EqualizeParse = null):void {
			if (!this.soundChannel) return;
			equalizeParse = equalizeParse ? equalizeParse : MasterEqualizer.getInstance().equalize;
			var transform:SoundTransform = new SoundTransform(this.soundTransform.volume * equalizeParse.volume, this.soundTransform.pan * equalizeParse.pan);
			transform.leftToLeft = this.soundTransform.leftToLeft * equalizeParse.leftSpeak;
			transform.rightToRight = this.soundTransform.rightToRight * equalizeParse.rightSpeak;
			this.soundChannel.soundTransform = transform;
		}
	}
}