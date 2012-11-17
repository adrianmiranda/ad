package com.ad.core {
	import com.ad.common.getLayer;
	import com.ad.data.Layers;
	import com.ad.data.Language;
	import com.ad.data.View;
	import com.ad.errors.ADError;
	import com.ad.events.ApplicationEvent;
	import com.ad.interfaces.ISection;
	import com.ad.proxy.nsapplication;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	use namespace nsapplication;
	public class ApplicationFacade extends ApplicationLoader {
		private var _container:DisplayObjectContainer;
		private var _navigation:Navigation;
		
		public function ApplicationFacade(key:String = null) {
			super(key);
		}
		
		public static function getInstance(key:String = null):ApplicationFacade {
			if (!hasInstance(key)) instances[key] = new ApplicationFacade(key);
			return instances[key] as ApplicationFacade;
		}
		
		override public function startup(binding:DisplayObject = null):void {
			this.validateContainer(binding);
			super.startup(this._container = DisplayObjectContainer(binding));
		}

		override protected function onRequestResult():void {
			super.onRequestResult();
			this._navigation = Navigation.getInstance(super.apiKey);
		}
		
		public function run(viewLayerId:String = null):void {
			this._navigation.registerViews(super.header);
			this._navigation.addEventListener(ApplicationEvent.INIT, this.onInitNavigation);
			this._navigation.addEventListener(ApplicationEvent.CHANGE, this.onChangeNavigation);
			this._navigation.addEventListener(ApplicationEvent.CHANGE_VIEW, this.onChangeView);
			this._navigation.addEventListener(ApplicationEvent.CHANGE_LANGUAGE, this.onChangeLanguage);
			if (Layers.shortcutTarget.hasOwnProperty(viewLayerId)) {
				this._container = getLayer(viewLayerId);
			}
			this._navigation.run(this._container);
		}
		
		public function setTitle(value:String):void {
			this._navigation.setTitle(value);
		}
		
		public function setLanguage(value:*):void {
			this._navigation.setLanguage(value);
		}
		
		public function navigateTo(value:*):void {
			this._navigation.navigateTo(value);
		}
		
		public function go(delta:int):void {
			this._navigation.go(delta);
		}
		
		public function up():void {
			this._navigation.up();
		}
		
		public function forward():void {
			this._navigation.forward();
		}
		
		public function back():void {
			this._navigation.back();
		}
		
		public function clearHistory():void {
			this._navigation.clearHistory();
		}
		
		public function get view():View {
			return this._navigation.view;
		}
		
		public function get language():Language {
			return this._navigation.language;
		}
		
		public function get pathNames():Array {
			return this._navigation.getPathNames();
		}
		
		public function get section():ISection {
			return this._navigation.section;
		}
		
		protected function onInitNavigation(event:ApplicationEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeNavigation(event:ApplicationEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeView(event:ApplicationEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeLanguage(event:ApplicationEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		public function get container():DisplayObjectContainer {
			return this._container;
		}
		
		public function get stage():Stage {
			return this.container ? this.container.stage : null;
		}
		
		protected function validateContainer(binding:DisplayObject):void {
			var error:String = '*Startup Failed* Binding ';
			if (!binding) {
				throw new ADError(error + 'missing required');
			}
			else if (!binding.hasOwnProperty('stage')) {
				throw new ADError(error + 'missing required property \'stage\'');
			}
			else if (!binding.stage) {
				throw new ADError(error + 'missing required being on stage');
			}
		}
		
		override public function dispose(flush:Boolean = false):void {
			this._navigation.dispose(flush);
			if (flush) {
				this._container = null;
			}
			super.dispose(flush);
		}
		
		override public function toString():String {
			return '[ApplicationFacade ' + super.apiKey + ']';
		}
	}
}