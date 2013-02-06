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
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class ThumbnailMax extends ButtonMax implements IThumb {
		private var _content:DisplayObject;
		private var _url:String;
		
		public function ThumbnailMax(urlOrRequest:* = null, hide:Boolean = false, allow:Boolean = false) {
			if (allow) {
				Security.allowDomain('*');
				Security.allowInsecureDomain('*');
			}
			if (urlOrRequest) {
				this.load(urlOrRequest);
			}
			super(hide);
		}

		override protected function onRemovedFromStage(event:Event):void {
			super.onRemovedFromStage(event);
			if (this._content && this._content.parent) {
				this._content.parent.removeChild(this._content);
				this._content = null;
			}
		}
		
		public function load(urlOrRequest:*):void {
			if (urlOrRequest is URLRequest) {
				this._url = urlOrRequest.url;
			} else if (urlOrRequest is String) {
				this._url = url;
			}
			if (this._url) {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onThumbIOError);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onThumbLoaded);
				loader.load(new URLRequest(this._url), new LoaderContext(false, ApplicationDomain.currentDomain));
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
			return '[ThumbnailMax ' + super.name + ']';
		}
	}
}