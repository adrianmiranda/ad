package com.ad.media {
	import com.ad.events.EventControl;
	
	import flash.display.Stage;
	import flash.net.NetStream;
    import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.events.StageVideoEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/media/StageVideo.html
	 */
	public class VideoStage extends EventControl {
		public static const READY:String = 'VideoStage.READY';
		private var _available:Boolean;
		private var _viewPort:Rectangle;
		private var _stageVideo:StageVideo;
		private var _stage:Stage;
		private var _depth:uint;
		private var _index:uint;
		private var _zoom:Point;
		private var _pan:Point;
		
		public function VideoStage(stage:Stage = null, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, index:uint = 0) {
			this._viewPort = new Rectangle(x, y, width, height);
			this._pan = new Point(0, 0);
			this._zoom = new Point(1, 1);
			this.setup(stage);
		}
		
		public function set x(value:Number):void {
			this._viewPort.x = value;
			this.update();
		}
		
		public function get x():Number {
			return this._viewPort.x;
		}
		
		public function set y(value:Number):void {
			this._viewPort.y = value;
			this.update();
		}
		
		public function get y():Number {
			return this._viewPort.y;
		}
		
		public function set width(value:Number):void {
			this._viewPort.width = value;
			this.update();
		}
		
		public function get width():Number {
			return this._viewPort.width;
		}
		
		public function get videoWidth():int {
			return this._stageVideo ? this._stageVideo.videoWidth : 0; 
		}
		
		public function set height(value:Number):void {
			this._viewPort.height = value;
			this.update();
		}
		
		public function get height():Number {
			return this._viewPort.height;
		}
		
		public function get videoHeight():int {
			return this._stageVideo ? this._stageVideo.videoHeight : 0; 
		}
		
		public function set zoom(value:Point):void {
			this._zoom = value || new Point(1, 1);
			if (this._stageVideo) this._stageVideo.zoom = this._zoom;
		}
		
		public function get zoom():Point {
		    return this._zoom;
		}
		
		public function set pan(value:Point):void {
			this._pan = value || new Point(0, 0);
			if (this._stageVideo) this._stageVideo.pan = this._pan;
		}
		
		public function get pan():Point {
			return this._pan;
		}
		
		public function set depth(value:int):void {
			this._depth = value;
			if (this._stageVideo) this._stageVideo.depth = this._depth;
		}
		
		public function get depth():int {
			return this._depth;
		}
		
		public function set viewPort(value:Rectangle):void {
			this._viewPort = value || new Rectangle(0, 0, 0, 0);
			this.update();
		}
		
		public function get viewPort():Rectangle {
			return this._viewPort;
		}
		
		public function set index(value:uint):void {
			if (value == this._index || !this._stage) return;
			this.clear();
			this._index = value;
			this.setup(this._stage);
		}
		
		public function get index():uint {
			return this._index;
		}
		
		public function get available():Boolean {
			return this._available;
		}
		
		public function get colorSpaces():Vector.<String> {
			return this._stageVideo ? this._stageVideo.colorSpaces : null;
		}
		
		public function get stage():Stage {
			return this._stage;
		}
		
		public function get stageVideo():StageVideo {
			return this._stageVideo;
		}
		
		public function attachNetStream(netStream:NetStream):void {
			if (this._stageVideo) {
				this._stageVideo.attachNetStream(netStream);
			}
		}
		
		public function setup(stage:Stage):void {
			this._stage = stage;
			if (this._stage && !this._stageVideo) {
				var videos:Vector.<StageVideo> = this._stage.stageVideos;
				if (videos && videos.length > 0) {
					this._stageVideo = videos[this._index] as StageVideo;
					if (this._stageVideo) {
						this._stageVideo.pan = this._pan;
						this._stageVideo.depth = this._depth;
						this._stageVideo.zoom = this._zoom;
						this._stageVideo.addEventListener(StageVideoEvent.RENDER_STATE, this.onRenderState, false, 0, true);
					}
					this._stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onAvailable);
					this.update();
				}
			}
		}
		
		private function onAvailable(event:StageVideoAvailabilityEvent):void {
			event.target.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, this.onAvailable);
			this._available = (event.availability == StageVideoAvailability.AVAILABLE);
			this._stage.dispatchEvent(new Event(Event.RESIZE));
			super.dispatchEvent(new Event(READY));
			this.update();
		}
		
		protected function clear():void {
			if (this._stageVideo) {
				this._stageVideo.attachNetStream(null);
				this._stageVideo.removeEventListener(StageVideoEvent.RENDER_STATE, this.onRenderState);
				this._stageVideo = null;
			}
		}
		
		public function onRenderState(event:StageVideoEvent):void {
			this.update();
		}
		
		public function update(event:Event = null):void {
			if (this._stageVideo) {
				this._stageVideo.viewPort = this._viewPort;
			}
		}
	}
}