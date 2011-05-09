package com.ad.events {
	import flash.events.Event;
	
	public class URIEvent extends Event {
		public static const CHANGE:String = 'URIEvent.CHANGE';
		
		public var url:String;
		public var window:String;
		public var external:Boolean;
		
		public function URIEvent(type:String, url:String = '', window:String = '', external:Boolean = false) { 
			super(type, false, false);
			this.url = url;
			this.window = window;
			this.external = external;
		}
		
		override public function clone():Event { 
			return new TransitionEvent(type, this.url, this.window, this.external);
		}
		
		override public function toString():String {
			return super.formatToString('URIEvent', 'type', 'url', 'window', 'external', 'eventPhase'); 
		}
	}
}