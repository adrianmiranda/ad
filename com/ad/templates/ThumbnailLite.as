package com.ad.templates {
	import com.ad.interfaces.IThumb;
	
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	public class ThumbnailLite extends ButtonLite implements IThumb {
		private var _content:DisplayObject;
		private var _url:String;
		
		public function ThumbnailLite(url:String = null, hide:Boolean = false, allow:Boolean = false) {
			if (allow) {
				Security.allowDomain('*');
				Security.allowInsecureDomain('*');
			}
			if (url) this.load(url);
			super(hide);
		}
		
		public function load(url:String):void {
			this._url = url;
			if (url) {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onThumbIOError);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onThumbLoaded);
				loader.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
			}
		}
		
		public function loadBytes(bytes:ByteArray):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onThumbIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onThumbLoaded);
			loader.loadBytes(bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
		}
		
		private function onThumbLoaded(event:Event):void {
			this._content = event.target.content;
			this.loaded();
		}
		
		private function onThumbIOError(event:IOErrorEvent):void {
			this.ioError();
		}
		
		public function get url():String {
			return this._url;
		}
		
		public function get content():DisplayObject {
			return this._content;
		}
		
		protected function loaded():void {
			// to override
		}
		
		protected function ioError():void {
			// to override
		}
		
		override public function toString():String {
			return '[ThumbnailLite ' + super.name + ']';
		}
	}
}