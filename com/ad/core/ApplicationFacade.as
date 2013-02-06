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
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
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
		
		public function classes(...rest:Array):void {
			Navigation.classes(rest.slice());
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
			this._navigation.fromHeader(super.header);
			this._navigation.addEventListener(ApplicationEvent.INIT, this.onInitNavigation);
			this._navigation.addEventListener(ApplicationEvent.CHANGE, this.onChangeNavigation);
			this._navigation.addEventListener(ApplicationEvent.CHANGE_VIEW, this.onChangeView);
			this._navigation.addEventListener(ApplicationEvent.CHANGE_LANGUAGE, this.onChangeLanguage);
			if (Layers.shortcutTarget.hasOwnProperty(viewLayerId)) {
				this._container = getLayer(viewLayerId);
			}
			this._navigation.run(this._container);
		}

		public function get parameters():Object {
			return this._navigation.parameters;
		}

		public function call(jsFunction:String, ...rest:Array):* {
			this._navigation.call.apply(null, [jsFunction].concat(rest));
		}
		
		public function href(url:String, target:String = '_self'):void {
			this._navigation.href(url, target);
		}

		public function popup(url:String, name:String = 'popup', options:String = '""', handler:String = ''):void {
			this._navigation.popup(url, name, options, handler);
		}

		public function getBaseURL():String {
			return this._navigation.getBaseURL();
		}

		public function getStrict():Boolean {
			return this._navigation.getStrict();
		}
		
		public function setStrict(strict:Boolean):void {
			this._navigation.setStrict(strict);
		}

		public function getHistory():Boolean {
			return this._navigation.getHistory();
		}

		public function setHistory(history:Boolean):void {
			this._navigation.setHistory(history);
		}

		public function getTracker():String {
			return this._navigation.getTracker();
		}

		public function setTracker(tracker:String):void {
			return this._navigation.setTracker(tracker);
		}

		public function getTitle():String {
			return this._navigation.getTitle();
		}

		public function getStatus():String {
			return this._navigation.getStatus();
		}

		public function setStatus(status:String):void {
			this._navigation.setStatus(status);
		}

		public function resetStatus():void {
			this._navigation.resetStatus();
		}

		public function getValue():String {
			return this._navigation.getValue();
		}

		public function getPath():String {
			return this._navigation.getPath();
		}

		public function getQueryString(path:String = null):String {
			return this._navigation.getQueryString(path);
		}

		public function hasQueryString(path:String = null):Boolean {
			return this._navigation.hasQueryString(path);
		}

		public function getParameter(param:String):Object {
			return this._navigation.getParameter(param);
		}

		public function getParameterNames():Array {
			return this._navigation.getParameterNames();
		}

		public function get history():Array {
			return this._navigation.history;
		}
		
		public function setTitle(value:String, delimiter:String = null):void {
			this._navigation.setTitle(value, delimiter);
		}
		
		public function setLanguage(value:* = null):Language {
			//return this._navigation.i18n::set(value);
			return null;
		}

		public function setView(value:* = null):View {
			//return this._navigation.area::set(value);
			return null;
		}
		
		public function navigateTo(value:*, query:Object = null):void {
			this._navigation.navigateTo(value, query);
		}

		public function calculateRoute(value:* = null):Boolean {
			return this._navigation.calculate(value);
		}

		public function reload():void {
			this._navigation.reload();
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

		public function get mistakeView():View {
			return this._navigation.mistakeView;
		}

		public function get standardLanguage():Language {
			return this._navigation.standardLanguage;
		}

		public function get standardView():View {
			return this._navigation.standardView;
		}

		public function get lastLanguage():Language {
			return this._navigation.lastLanguage;
		}

		public function get lastView():View {
			return this._navigation.lastView;
		}
		
		public function get language():Language {
			return this._navigation.language;
		}

		public function get view():View {
			return this._navigation.view;
		}
		
		public function get languages():Language {
			return this._navigation.languages;
		}

		public function get baseViews():View {
			return this._navigation.base;
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