package com.ad.core {
	import com.ad.events.EventControl;
	import com.ad.proxy.nsapplication;

	use namespace nsapplication;
	public class ApplicationCore extends EventControl {
		protected const MULTITON_MESSAGE:String = 'ApplicationCore instance for this API key already initialised!';
		protected static var instances:Array = new Array();
		private static var _numInstances:int = -1;
		private static var _firstKey:String;
		private var _apiKey:String;
		private var _vars:Object;
		
		public function ApplicationCore(key:String = null) {
			if (hasInstance(key)) throw Error(MULTITON_MESSAGE);
			this.initializeKey(key, this);
			this.initialize();
		}
		
		public static function getInstance(key:String = null):ApplicationCore {
			if (!hasInstance(key)) instances[key] = new ApplicationCore(key);
			return instances[key];
		}
		
		private function initializeKey(key:String, instance:ApplicationCore):void {
			key = (key || version);
			if (_numInstances == -1) _firstKey = key, _numInstances++;
			instances[this._apiKey = key] = instance;
			_numInstances++;
		}
		
		protected function initialize():void {
			// to override.
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
			return 'Application-' + numInstances;
		}
		
		public final function get apiKey():String {
			return this._apiKey;
		}
		
		public final function get vars():Object {
			this._vars ||= {};
			return this._vars;
		}
		
		public function dispose(flush:Boolean = false):void {
			super.removeAllEventListener();
			for (var key:String in this._vars) {
				delete this._vars[key];
			}
			this._vars = null;
			removeInstance(this.apiKey);
		}
		
		override public function toString():String {
			return '[ApplicationCore' + this.apiKey + ']';
		}
	}
}