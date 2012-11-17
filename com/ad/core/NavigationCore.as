package com.ad.core {
	import com.ad.events.EventControl;
	import com.ad.events.ApplicationEvent;
	import com.ad.utils.BranchUtils;
	import com.ad.errors.ADError;
	import com.ad.utils.Browser;
	import com.asual.SWFAddressEvent;
	import com.asual.SWFAddress;

	import flash.display.DisplayObjectContainer;
	
	[Event(type='ApplicationEvent', name='ApplicationEvent.EXTERNAL_CHANGE')]
	[Event(type='ApplicationEvent', name='ApplicationEvent.INTERNAL_CHANGE')]
	[Event(type='ApplicationEvent', name='ApplicationEvent.STARTUP')]
	[Event(type='ApplicationEvent', name='ApplicationEvent.CHANGE')]
	[Event(type='ApplicationEvent', name='ApplicationEvent.INIT')]

	public class NavigationCore extends EventControl {
		protected const MULTITON_MESSAGE:String = 'NavigationCore instance for this API key already initialised!';
		protected static var instances:Array = new Array();
		private static var _numInstances:int = -1;
		private static var _firstKey:String;
		private static var _title:String;
		private static var _bread:String;
		private var _container:DisplayObjectContainer;
		private var _apiKey:String;
		private var _vars:Object;
		private var _history:Array;
		private var _depth:int;
		
		public function NavigationCore(key:String = null) {
			if (hasInstance(key)) throw new ADError(MULTITON_MESSAGE);
			this.initializeKey(key, this);
			this.initializeHistory();
			this.initialize();
		}
		
		public static function getInstance(key:String = null):NavigationCore {
			if (!hasInstance(key)) instances[key] = new NavigationCore(key);
			return instances[key];
		}
		
		private function initializeKey(key:String, instance:NavigationCore):void {
			key = (key || version);
			if (_numInstances == -1) _firstKey = key, _numInstances++;
			instances[this._apiKey = key] = instance;
			_numInstances++;
		}

		private function initializeHistory():void {
			this._history = new Array();
		}

		protected function initialize():void {
			// to override.
		}

		protected function validateContainer(container:DisplayObjectContainer):void {
			var error:String = '*NavigationCore* Container ';
			if (!container) {
				throw new ADError(error + 'missing required');
			}
		}
		
		public function run(container:DisplayObjectContainer):void {
			this.validateContainer(this._container = container);
			SWFAddress.addEventListener(SWFAddressEvent.EXTERNAL_CHANGE, this.onExternalChange);
			SWFAddress.addEventListener(SWFAddressEvent.INTERNAL_CHANGE, this.onInternalChange);
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onStartup);
			SWFAddress.addEventListener(SWFAddressEvent.INIT, this.onInit);
		}
		
		public static function hasInstance(key:String):Boolean {
			return instances[key] != null;
		}
		
		public static function removeInstance(key:String):void {
			if (!hasInstance(key)) return;
			delete instances[key];
			_numInstances--;
		}
		
		public static function get instanceList():Array {
			return instances.slice();
		}
		
		public static function get numInstances():uint {
			return _numInstances + 1;
		}
		
		public static function get defaultKey():String {
			return _firstKey;
		}
		
		public static function get version():String {
			return '1.0';
		}
		
		public static function get uniqueName():String {
			return 'Navigation-' + numInstances;
		}
		
		public final function get apiKey():String {
			return this._apiKey;
		}
		
		public final function get vars():Object {
			this._vars ||= {};
			return this._vars;
		}

		protected function onExternalChange(event:SWFAddressEvent):void {
			this.externalChange();
			super.dispatchEvent(new ApplicationEvent(ApplicationEvent.EXTERNAL_CHANGE, this.apiKey));
		}

		protected function onInternalChange(event:SWFAddressEvent):void {
			this.internalChange();
			super.dispatchEvent(new ApplicationEvent(ApplicationEvent.INTERNAL_CHANGE, this.apiKey));
		}

		protected function onStartup(event:SWFAddressEvent):void {
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onChange);
			SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, this.onStartup);
			this.startup();
			super.dispatchEvent(new ApplicationEvent(ApplicationEvent.STARTUP, this.apiKey));
		}

		protected function onChange(event:SWFAddressEvent):void {
			this.change();
			super.dispatchEvent(new ApplicationEvent(ApplicationEvent.CHANGE, this.apiKey));
		}

		protected function onInit(event:SWFAddressEvent):void {
			this.init();
			super.dispatchEvent(new ApplicationEvent(ApplicationEvent.INIT, this.apiKey));
		}

		public function call(jsFunction:String, ...rest:Array):* {
			Browser.call.apply(null, [jsFunction].concat(rest));
		}

		public function get parameters():Object {
			return Browser.queryString;
		}

		public function get history():Array {
			return this._history.slice();
		}

		public function clearHistory():void {
			var id:int = this._history.length;
			while (id--) {
				this._history.splice(id, 1);
			}
		}

		public function back():void {
			if (this._depth > 0) {
				this._depth--;
				if (this._history[this._depth]) {
					this.navigateTo(this._history[this._depth]);
				}
			}
		}
		
		public function forward():void {
			if (this._depth < this._history.length - 1) {;
				this.navigateTo(this._history[++this._depth]);
			}
		}

		public function up():void {
			SWFAddress.up();
		}

		public function go(delta:int):void {
			SWFAddress.go(delta);
		}

		public function href(url:String, target:String = '_self'):void {
			SWFAddress.href(url, target);
		}

		public function popup(url:String, name:String='popup', options:String='""', handler:String=''):void {
			SWFAddress.popup(url, name, options, handler);
		}

		public function getBaseURL():String {
			return SWFAddress.getBaseURL();
		}

		public function getStrict():Boolean {
			return SWFAddress.getStrict();
		}

		public function setStrict(strict:Boolean):void {
			SWFAddress.setStrict(strict);
		}

		public function getHistory():Boolean {
			return SWFAddress.getHistory();
		}

		public function setHistory(history:Boolean):void {
			SWFAddress.setHistory(history);
		}

		public function getTracker():String {
			return SWFAddress.getTracker();
		}

		public function setTracker(tracker:String):void {
			SWFAddress.setTracker(tracker);
		}

		public function getTitle():String {
			return SWFAddress.getTitle();
		}

		public function setTitle(title:String, delimiter:String = null):void {
			_title ||= title ||= 'AdFramework';
			if (delimiter != null) {
				_bread = delimiter;
				for each (var crumb:String in this.getPathNames()) {
					title += _bread + crumb;
				}
			}
			SWFAddress.setTitle(title);
		}

		public function getStatus():String {
			return SWFAddress.getStatus();
		}

		public function setStatus(status:String):void {
			SWFAddress.setStatus(status);
		}

		public function resetStatus():void {
			SWFAddress.resetStatus();
		}

		public function getValue():String {
			return SWFAddress.getValue();
		}

		public function navigateTo(value:String, query:Object = null):void {
			if (query) {
				value = value.concat('?');
				for (var key:String in query) {
					value = value.concat(key + '=' + query[key] + '&');
				}
				value = value.substring(0, (value.length - 1));
			}
			value = this.apiKey != version ? this.apiKey + '/' + value : value;
			this._history[this._depth] = BranchUtils.arrange(value);
			SWFAddress.setValue(this._history[this._depth++]);
		}

		public function getPath():String {
			return SWFAddress.getPath();
		}

		public function getPathNames():Array {
			return SWFAddress.getPathNames();
		}

		public function getQueryString(path:String = null):String {
			return BranchUtils.getQueryString(path || Browser.href);
		}
		
		public function hasQueryString(path:String = null):Boolean {
			return this.getQueryString(path) != null;
		}

		public function getParameter(param:String):Object {
			return SWFAddress.getParameter(param);
		}

		public function getParameterNames():Array {
			return SWFAddress.getParameterNames() || [];
		}

		protected function externalChange():void {
			// to override.
		}

		protected function internalChange():void {
			// to override.
		}

		protected function startup():void {
			// to override.
		}

		protected function change():void {
			// to override.
		}

		protected function init():void {
			// to override.
		}

		public function get container():DisplayObjectContainer {
			return this._container;
		}

		public function dispose(flush:Boolean = false):void {
			SWFAddress.removeEventListener(SWFAddressEvent.EXTERNAL_CHANGE, this.onExternalChange);
			SWFAddress.removeEventListener(SWFAddressEvent.INTERNAL_CHANGE, this.onInternalChange);
			SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, this.onChange);
			SWFAddress.removeEventListener(SWFAddressEvent.INIT, this.onInit);
			super.removeAllEventListener();
			this.clearHistory();
			for (var key:String in this._vars) {
				delete this._vars[key];
			}
			if (flush) {
				this._history = null;
				this._vars = null;
			}
			removeInstance(this.apiKey);
		}
		
		override public function toString():String {
			return '[NavigationCore' + this.apiKey + ']';
		}
	}
}