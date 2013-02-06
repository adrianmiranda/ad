package com.ad.events {
	import com.ad.data.View;
	import com.ad.data.Language;
	import com.ad.core.Deeplink;
	
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class DeeplinkEvent extends Event {
		public static const INTERNAL_CHANGE:String = 'DeeplinkEvent.INTERNAL_CHANGE';
		public static const EXTERNAL_CHANGE:String = 'DeeplinkEvent.EXTERNAL_CHANGE';
		public static const CHANGE_LANGUAGE:String = 'DeeplinkEvent.CHANGE_LANGUAGE';
		public static const CHANGE_VIEW:String = 'DeeplinkEvent.CHANGE_VIEW';
		public static const CHANGE:String = 'DeeplinkEvent.CHANGE';
		public static const INIT:String = 'DeeplinkEvent.INIT';
		private var _language:Language;
		private var _view:View;
		private var _value:String;
		private var _path:String;
		private var _paths:Object;
		private var _pathNames:Array;
		private var _parameterNames:Array;
		private var _parameters:Object;
		private var _queryString:String;
		private var _readings:int;
		
		public function DeeplinkEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function get currentTarget():Object {
			return Deeplink;
		}
		
		override public function get target():Object {
			return Deeplink;
		}
		
		public function get language():Language {
			if (this._language == null) {
				this._language = Deeplink.language;
			}
			return this._language;
		}
		
		public function get view():View {
			if (this._view == null) {
				this._view = Deeplink.view;
			}
			return this._view;
		}
		
		public function get value():String {
			if (this._value == null) {
				this._value = Deeplink.getValue();
			}
			return this._value;
		}
		
		public function get path():String {
			if (this._path == null) {
				this._path = Deeplink.getPath();
			}
			return this._path;
		}
		
		public function get header():Object {
			if (this._paths == null) {
				this._paths = Deeplink.header;
			}
			return this._paths;
		}
		
		public function get pathNames():Array {
			if (this._pathNames == null) {
				this._pathNames = Deeplink.getPathNames();
			}
			return this._pathNames;
		}
		
		public function get parameters():Object {
			if (this._parameters == null) {
				this._parameters = new Object();
				for (var id:int = 0; id < parameterNames.length; id++) {
					this._parameters[parameterNames[id]] = Deeplink.getParameter(parameterNames[id]);
				}
			}
			return this._parameters;
		}
		
		public function get parameterNames():Array {
			if (this._parameterNames == null) {
				this._parameterNames = Deeplink.getParameterNames();
			}
			return this._parameterNames;
		}
		
		public function get queryString():String {
			if (this._queryString == null) {
				this._queryString = Deeplink.getQueryString();
			}
			return this._queryString ? '?' + this._queryString : '';
		}
		
		public function get readings():int {
			if (this._readings == 0) {
				this._readings = Deeplink.readings;
			}
			return this._readings;
		}
		
		public override function clone():Event {
			return new DeeplinkEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String {
			return super.formatToString('DeeplinkEvent', 'type', 'item', 'value', 'path', 'paths', 'pathNames', 'parameterNames', 'parameters', 'queryString', 'bubbles', 'cancelable', 'eventPhase'); 
		}
	}
}