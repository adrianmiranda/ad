package com.ad.media {
	import com.ad.templates.BaseNano;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.Loader;
	import flash.system.Security;
	import flash.net.URLRequest;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class YouTubePlayer extends BaseNano {
		private static const YOUTUBE_EMBEDDED_PLAYER_URL:String = 'http://www.youtube.com/v/VIDEO_ID?version=3&rel=0';
		
		public static const PLAYER_READY:String = 'playerReady';
		public static const QUALITY_SMALL:String = 'small';
		public static const QUALITY_MEDIUM:String = 'medium';
		public static const QUALITY_LARGE:String = 'large';
		public static const QUALITY_HD720:String = 'hd720';
		public static const QUALITY_HD1080:String = 'hd1080';
		public static const QUALITY_HIGHRES:String = 'highres';
		public static const QUALITY_DEFAULT:String = 'default';
		
		private var _player:Object;
		private var _loader:Loader;
		private var _width:Number;
		private var _height:Number;
		
		public function YouTubePlayer(width:int = 320, height:int = 240, resizable:Boolean = false) {
			Security.allowDomain('*');
			Security.allowDomain('www.youtube.com');
			Security.allowDomain('img.youtube.com');
			Security.allowDomain('youtube.com');
			Security.allowDomain('s.ytimg.com');
			Security.allowDomain('i.ytimg.com');
			Security.loadPolicyFile('http://img.youtube.com/crossdomain.xml');
			Security.loadPolicyFile('http://i.ytimg.com/crossdomain.xml');
			Security.loadPolicyFile('http://s.ytimg.com/crossdomain.xml');

			for (var id:int = 1; id < 5; id++) {
				Security.loadPolicyFile('http://i' + id + '.ytimg.com/crossdomain.xml');
			}
			
			_width = width;
			_height = height;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			
			super(resizable);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// SETUP
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function load(video:*):void {
			if (video is URLRequest) video = video.url;
			if (/^http/.test(video)) video = YouTubePlayer.getIdFromURL(video);
			var url:String = YOUTUBE_EMBEDDED_PLAYER_URL.split('VIDEO_ID').join(video);
			_loader.load(new URLRequest(url));
		}
		
		override protected function initialize():void {
			// no yet implemented
		}
		
		override protected function finalize():void {
			if (_player) {
				_player.destroy();
				_player = null;
			}
			if (_loader) {
				_loader.unload();
				if (contains(_loader)) {
					removeChild(_loader);
				}
				_loader = null;
			}
		}

		override public function arrange():void {
			setSize(screen.width, screen.height);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// LOAD
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function onLoaderInit(event:Event):void {
			addChild(_loader);
			_loader.content.addEventListener('onReady', onPlayerReady);
			_loader.content.addEventListener('onError', onPlayerError);
			_loader.content.addEventListener('onStateChange', onPlayerStateChange);
			_loader.content.addEventListener('onPlaybackQualityChange', onVideoPlaybackQualityChange);
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit);
		}
		
		private function onPlayerReady(event:Event):void {
			trace('player ready:', Object(event).data);
			_player = _loader.content;
			setSize(_width, _height);
			super.dispatchEvent(new Event(PLAYER_READY));
		}
		
		private function onPlayerError(event:Event):void {
			trace('player error:', Object(event).data);
		}
		
		private function onPlayerStateChange(event:Event):void {
			trace('player state:', Object(event).data);
		}
		
		private function onVideoPlaybackQualityChange(event:Event):void {
			trace('video quality:', Object(event).data);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// UTILS
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function setSize(width:int, height:int):void {
			_width = width;
			_height = height;
			if (_player && _player.setSize is Function) {
				_player.setSize(_width, _height);
			}
		}
		
		public function cueVideoById(videoID:String, quality:String = QUALITY_DEFAULT):void {
			_player && _player.cueVideoById(videoID, 0, quality);
		}
		
		public function loadVideoById(videoID:String, quality:String = QUALITY_DEFAULT):void {
			_player && _player.loadVideoById(videoID, 0, quality);
		}
		
		public function cueVideoByUrl(url:String, quality:String = QUALITY_DEFAULT):void {
			_player && _player.cueVideoByUrl(url, 0, quality);
		}
		
		public function loadVideoByUrl(url:String, quality:String = QUALITY_DEFAULT):void {
			_player && _player.loadVideoByUrl(url, 0, quality);
		}
		
		public static function getIdFromURL(url:String):String {
			var parts:Array = [];
			if (!url) {
				return '';
			} else if (url.indexOf('watch?v=') != -1) {
				parts = url.split('watch?v=');
			} else if (url.indexOf('watch/v/') != -1) {
				parts = url.split('watch/v/');
			} else if (url.indexOf('youtu.be/') != -1) {
				parts = url.split('youtu.be/');
			}
			return String(parts[1]).split('/').join('');
		}
		
		public static function getThumbnail(video:String):URLRequest {
			if (/^http/.test(video)) video = YouTubePlayer.getIdFromURL(video);
			return new URLRequest('http://img.youtube.com/vi/' + video + '/0.jpg');
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// PATTERN
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function get width():Number {
			return _width;
		}
		
		override public function get height():Number {
			return _height;
		}
	}
}