package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.File;
	import com.ad.data.Header;
	import com.ad.errors.ADError;
	import com.ad.events.EventControl;
	import com.ad.utils.Browser;
	import com.greensock.events.LoaderEvent;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	
	import __AS3__.vec.Vector;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.media.SoundLoaderContext;
	import flash.system.LoaderContext;
	
	public class ApplicationLoader extends ApplicationRequest {
		private var _soundLoaderContext:SoundLoaderContext;
		private var _loaderContext:LoaderContext;
		private var _loader:LoaderMax;
		private var _load:Boolean;
		
		public function ApplicationLoader(key:String = null) {
			super(key);
		}
		
		public static function getInstance(key:String = null):ApplicationLoader {
			if (!hasInstance(key)) instances[key] = new ApplicationLoader(key);
			return instances[key] as ApplicationLoader;
		}
		
		public function classes(...rest:Array):void {
			// no need to do anything - we just want to force the classes to get compiled in the swf.
		}
		
		public function loaders(...rest:Array):void {
			LoaderMax.activate(rest.slice());
		}
		
		public function plugins(...rest:Array):void {
			TweenPlugin.activate(rest.slice());
		}
		
		override protected function initialize():void {
			this._loaderContext = new LoaderContext();
			this._soundLoaderContext = new SoundLoaderContext();
			LoaderMax.defaultContext = this._loaderContext;
		}
		
		override public function startup(binding:DisplayObject = null):void {
			super.startup(binding);
			this._load = true;
		}
		
		override protected function onRequestResult():void {
			super.onRequestResult();
			if (super.header.hasFiles) {
				this.loadHeader(super.header);
			}
		}
		
		public function load():void {
			this._load = true;
			if (this._loader) {
				this._loader.load();
			}
		}
		
		public function resume():void {
			this._load = true;
			if (this._loader) {
				this._loader.resume();
			}
		}
		
		public function pause():void {
			this._load = false;
			if (this._loader) {
				this._loader.pause();
			}
		}
		
		public function stop(flush:Boolean = false):void {
			this._load = false;
			if (this._loader) {
				this.pause();
				this.removeLoaderListeners();
				if (flush) {
					this.unload();
				}
				this._loader = null;
			}
		}
		
		public function unload():void {
			this._load = false;
			if (this._loader) {
				this._loader.unload();
			}
		}
		
		protected function loadHeader(header:Header):void {
			if (this._loader) this.stop(true);
			this._loader = new LoaderMax( { name:'header', maxConnections:header.connections } );
			this._loader.addEventListener(LoaderEvent.COMPLETE, this.onHeaderComplete);
			this.appendFiles(header.files);
			this._loader.load();
		}
		
		protected function prepareViewLoader(view:View):void {
			if (this._loader) this.stop();
			this._loader = new LoaderMax( { maxConnections:super.header.connections } );
			this._loader.name = view.uniqueId;
			this.appendFiles(view.files);
			this.addLoaderListeners();
		}
		
		public function appendFiles(files:Vector.<File>):void {
			for each (var file:File in files) {
				this.appendFile(file);
			}
		}
		
		public function appendFile(file:File):void {
			if (this._loader) {
				trace('-------->', file.url);
				var core:LoaderCore = LoaderMax.parse(file.url, { name:file.id, noCache:file.noCache } );
				core.vars.context = core is MP3Loader ? this._soundLoaderContext : this._loaderContext;
				core.vars.estimatedBytes = file.bytes;
				this._loader.append(core);
			} else {
				throw new ADError('*Invalid View Loader* ApplicationLoader call \'prepareViewLoader\' before departure');
			}
		}
		
		public function getContent(nameOrURL:String):* {
			return LoaderMax.getContent(nameOrURL);
		}
		
		protected function onHeaderComplete(event:LoaderEvent):void {
			this._loader.removeEventListener(LoaderEvent.COMPLETE, this.onHeaderComplete);
			var load:Boolean = this._load;
			if (super.vars.onReady) {
				super.vars.onReady.apply(null, super.vars.onReadyParams);
			}
			if (super.header.views.root.hasFiles) {
				this.prepareViewLoader(super.header.views.root);
			}
			if (load) {
				this.load();
			}
		}
		
		protected function onViewChildProgress(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewChildComplete(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewChildCancel(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewChildFail(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewChildOpen(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewProgress(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onComplete(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewCancel(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewUnload(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewError(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewFail(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewOpen(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onViewInit(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		// ao invés de usar dois métodos, um pra remover outro pra adicionar, resumir pra uma usando listeners(boolean);
		// nas chamadas
		private function addLoaderListeners():void {
			if (this._loader && !this._loader.hasEventListener(LoaderEvent.COMPLETE)) {
				this._loader.addEventListener(LoaderEvent.CHILD_PROGRESS, this.onViewChildProgress);
				this._loader.addEventListener(LoaderEvent.CHILD_COMPLETE, this.onViewChildComplete);
				this._loader.addEventListener(LoaderEvent.CHILD_CANCEL, this.onViewChildCancel);
				this._loader.addEventListener(LoaderEvent.CHILD_FAIL, this.onViewChildFail);
				this._loader.addEventListener(LoaderEvent.CHILD_OPEN, this.onViewChildOpen);
				this._loader.addEventListener(LoaderEvent.PROGRESS, this.onViewProgress);
				this._loader.addEventListener(LoaderEvent.COMPLETE, this.onComplete);
				this._loader.addEventListener(LoaderEvent.CANCEL, this.onViewCancel);
				this._loader.addEventListener(LoaderEvent.UNLOAD, this.onViewUnload);
				this._loader.addEventListener(LoaderEvent.ERROR, this.onViewError);
				this._loader.addEventListener(LoaderEvent.FAIL, this.onViewFail);
				this._loader.addEventListener(LoaderEvent.OPEN, this.onViewOpen);
				this._loader.addEventListener(LoaderEvent.INIT, this.onViewInit);
			}
		}
		
		private function removeLoaderListeners():void {
			if (this._loader && this._loader.hasEventListener(LoaderEvent.COMPLETE)) {
				this._loader.removeEventListener(LoaderEvent.CHILD_COMPLETE, this.onViewChildComplete);
				this._loader.removeEventListener(LoaderEvent.CHILD_PROGRESS, this.onViewChildProgress);
				this._loader.removeEventListener(LoaderEvent.CHILD_CANCEL, this.onViewChildCancel);
				this._loader.removeEventListener(LoaderEvent.CHILD_FAIL, this.onViewChildFail);
				this._loader.removeEventListener(LoaderEvent.CHILD_OPEN, this.onViewChildOpen);
				this._loader.removeEventListener(LoaderEvent.COMPLETE, this.onComplete);
				this._loader.removeEventListener(LoaderEvent.PROGRESS, this.onViewProgress);
				this._loader.removeEventListener(LoaderEvent.CANCEL, this.onViewCancel);
				this._loader.removeEventListener(LoaderEvent.ERROR, this.onViewError);
				this._loader.removeEventListener(LoaderEvent.FAIL, this.onViewFail);
				this._loader.removeEventListener(LoaderEvent.OPEN, this.onViewOpen);
				this._loader.removeEventListener(LoaderEvent.INIT, this.onViewInit);
			}
		}
		
		public function set onReady(closure:Function):void {
			super.vars.onReady = closure;
		}
		
		public function set onReadyParams(value:Array):void {
			super.vars.onReadyParams = value;
		}
		
		override public function dispose(flush:Boolean = false):void {
			this.stop(flush);
			if (flush) {
				this._soundLoaderContext = null;
				this._loaderContext = null;
			}
			super.dispose(flush);
		}
		
		override public function toString():String {
			return '[ApplicationLoader ' + super.apiKey + ']';
		}
	}
}