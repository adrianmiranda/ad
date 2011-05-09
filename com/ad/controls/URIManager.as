package com.ad.utils {
	import com.ad.events.URIEvent;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.events.Event;
	
	public final class URIManager extends URIComposite {
		
		public function URIManager() {
			// no yet implement
		}
		
		private function onURIChange(event:URIEvent):void {
			super.dispatchEvent(event.clone());
			super.dispatchEvent(new URIEvent(URIEvent.CHANGE));
		}
	}
}


package com.ad.utils {
	import com.ad.data.DeepLinkData;
	import com.ad.events.DeepLinkEvent;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	/**
	 * @author Adrian Miranda
	 */
	public final class DeepLink {
		private static var _history:Array = new Array();
		private static var _currentPosition:int = 0;
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _title:String = new String();
		private static var _delimiter:String = new String(' . ');
		private static var _paths:Object = new Object();
		private static var _deeplinkDefault:String;
		private static var _deeplinkError:String;
		private static var _deeplinkCurrent:String = new String('4fc06d9e-d3c9-466d-98e9-82ccd7ac02d8');
		private static var _currentItem:DeepLinkData;
		private static var _currentSource:String = new String();
		private static var _readings:int;
		
		public function DeepLink():void {
			throw new Error('DeepLink is a static class. Do not create instance of DeepLink class');
		}
		
		//// Utils ////////////////////////////////////////////////////////
		
		public static function hasPath(deeplink:String):Boolean {
			return Boolean(_paths[deeplink]);
		}
		
		public static function getPaths():Object {
			return _paths;
		}
		
		public static function get defaultPath():String {
			return _deeplinkDefault;
		}
		
		public static function get errorPath():String {
			return _deeplinkError;
		}
		
		public static function getItemByValue(value:String):DeepLinkData {
			return _paths[value];
		}
		
		public static function get item():DeepLinkData {
			return _currentItem;
		}
		
		public static function get readings():int {
			return _readings;
		}
		
		//// Proxy ////////////////////////////////////////////////////////
		
		public static function getTitle():String {
			return _title;
		}
		
		public static function setTitle(title:String, delimiter:String = ' . '):void {
			_title = title;
			_delimiter = (!delimiter) ? _delimiter : delimiter;
		}
		
		public static function back():void {
			if (_currentPosition > 0) {
				_currentPosition--;
				if (_history[_currentPosition] != undefined) {
					goto(_history[_currentPosition]);
				}
				else if (_deeplinkDefault) {
					goto(_paths[_deeplinkDefault].deeplink);
				}
			}
		}
		
		public static function forward():void {
			if (_currentPosition < _history.length - 1) {
				_currentPosition++;
				goto(_history[_currentPosition]);
			}
		}
		
		//// Register /////////////////////////////////////////////////////
		
		public static function registerDefaultPath(deeplink:String):void {
			if (!_deeplinkDefault) {
				_deeplinkDefault = recognizeAddress(deeplink);
				_currentItem = _paths[_deeplinkDefault];
			}
		}
		
		public static function registerErrorPath(deeplink:String):void {
			if (!_deeplinkError) {
				_deeplinkError = recognizeAddress(deeplink);
			}
		}
		
		public static function registerPath(deeplinkItem:DeepLinkData):void {
			deeplinkItem.deeplink = recognizeAddress(deeplinkItem.deeplink);
			var add:Boolean = true;
			for (var deeplink:String in _paths) {
				if (deeplink == deeplinkItem.deeplink) {
					add = false;
				}
			}
			if (add) {
				_paths[deeplinkItem.id] = deeplinkItem;
				_paths[deeplinkItem.label] = deeplinkItem;
				_paths[deeplinkItem.source] = deeplinkItem;
				_paths[deeplinkItem.deeplink] = deeplinkItem;
			}
		}
		
		public static function cleanRegistryPaths():void {
			_paths = new Object();
		}
		
		public static function cleanDefaultPaths():void {
			_deeplinkDefault = null;
			_deeplinkError = null;
		}
		
		//// Manager //////////////////////////////////////////////////////
		
		private static function recognizeAddress(value:String):String {
			var index:Number = value.indexOf('?');
			var hasQuery:Boolean = ((index != -1) && (index < value.length));
			var query:String = (hasQuery) ? value.substr(index) : '';
			if (hasQuery) value = value.substring(0, index);
			
			if (value.charAt(value.length - 1) != '/') {
				value = value + '/';
			}
			if (value.charAt(0) != '/') {
				value = '/' + value;
			}
			return value + query;
		}
		
		public static function goto(value:String):void {
			value = recognizeAddress(value);
			if (_deeplinkCurrent != value) {
				_deeplinkCurrent = value;
				
				var index:Number = value.indexOf('?');
				var hasQuery:Boolean = ((index != -1) && (index < value.length));
				var query:String = (hasQuery) ? value.substr(index) : '';
				if (hasQuery) value = value.substring(0, index);
				
				if (value == '/' || value == '') {
					if (_deeplinkDefault) {
						_currentSource = _paths[_deeplinkDefault].source;
						value = _paths[_deeplinkDefault].deeplink;
					}
					else {
						trace('call \'registerDefaultPath\' before departure');
						return;
					}
				}
				else if (_paths[value] == undefined) {
					if (_deeplinkError) {
						_currentSource = _paths[_deeplinkError].source;
						value = _paths[_deeplinkError].deeplink;
					}
					else {
						trace('call \'registerErrorPath\' before departure');
						return;
					}
				}
				else {
					_currentSource = _paths[value].source;
				}
				
				SWFAddress.setValue(value + query);
			}
		}
		
		public static function gotoErrorPath():void {
			if (_deeplinkError) {
				goto(_paths[_deeplinkError].deeplink);
			}
		}
		
		public static function gotoDefaultPath():void {
			if (_deeplinkDefault) {
				goto(_paths[_deeplinkDefault].deeplink);
			}
		}
		
		private static function dispatchChange(event:SWFAddressEvent):void {
			var value:String = recognizeAddress(event.value);
			var index:Number = value.indexOf('?');
			var hasQuery:Boolean = ((index != -1) && (index < value.length));
			var query:String = (hasQuery) ? value.substr(index) : '';
			if (hasQuery) value = value.substring(0, index);
			
			if (value == '/' || value == '') {
				if (_deeplinkDefault) {
					_currentSource = _paths[_deeplinkDefault].source;
					value = _paths[_deeplinkDefault].deeplink;
				}
				else {
					trace('call \'registerDefaultPath\' before departure');
					return;
				}
			}
			else if (_paths[value] == undefined) {
				if (_deeplinkError) {
					_currentSource = _paths[_deeplinkError].source;
					value = _paths[_deeplinkError].deeplink;
				}
				else {
					trace('call \'registerErrorPath\' before departure');
					return;
				}
			}
			else {
				_currentSource = _paths[value].source;
			}
			if (!_readings || value != _currentItem.deeplink)
			{
				_readings++;
			}
			
			_currentPosition++;
			_currentItem = _paths[value];
			_history[_currentPosition] = value + query;
			
			var title:String = _title;
			for each (var name:String in event.pathNames) {
				title += _delimiter + name.substr(0, 1).toUpperCase() + name.substr(1);
			}
			//SWFAddress.setTitle(title);
			
			dispatchEvent(new DeepLinkEvent(DeepLinkEvent.CHANGE, false, false));
		}	
	}
}