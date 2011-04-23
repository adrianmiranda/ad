package com.ad.templates {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class Thumbnail extends Button {
		private var _bmp:Bitmap;
		
		public function Thumbnail(url:String) {
			super.visible = false;
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url), new LoaderContext(false, null, null));
			loader.addEventListener(Event.COMPLETE, onThumbLoadComplete);
			super(true);
		}
		
		private function onThumbLoadComplete(evt:Event):void {
			this._bmp = evt.target.content as Bitmap;
			this._bmp.pixelSnapping = PixelSnapping.NEVER;
			this._bmp.cacheAsBitmap = true;
			this._bmp.smoothing = true;
			super.addChild(_bmp);
			super.visible = true;
			this.thumbLoaded();
		}
		
		protected function thumbLoaded():void {
			// to override
		}
	}
}