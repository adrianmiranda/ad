package com.ad.events {
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class TransitionEvent extends Event {
		public static const BEFORE_PRELOAD:String = 'TransitionEvent.BEFORE_PRELOAD';
		public static const AFTER_PRELOAD:String = 'TransitionEvent.AFTER_PRELOAD';
		public static const BEFORE_TRANSITION_IN:String = 'TransitionEvent.BEFORE_TRANSITION_IN';
		public static const TRANSITION_IN:String = 'TransitionEvent.TRANSITION_IN';
		public static const AFTER_TRANSITION_IN:String = 'TransitionEvent.AFTER_TRANSITION_IN';
		public static const TRANSITION_IN_COMPLETE:String = 'TransitionEvent.TRANSITION_IN_COMPLETE';
		public static const BEFORE_TRANSITION_OUT:String = 'TransitionEvent.BEFORE_TRANSITION_OUT';
		public static const TRANSITION_OUT:String = 'TransitionEvent.TRANSITION_OUT';
		public static const AFTER_TRANSITION_OUT:String = 'TransitionEvent.AFTER_TRANSITION_OUT';
		public static const TRANSITION_OUT_COMPLETE:String = 'TransitionEvent.TRANSITION_OUT_COMPLETE';
		
		public var url:String;
		public var window:String;
		public var external:Boolean;
		
		public function TransitionEvent(type:String, url:String = '', window:String = '', external:Boolean = false) { 
			super(type, false, false);
			this.url = url;
			this.window = window;
			this.external = external;
		}
		
		override public function clone():Event { 
			return new TransitionEvent(type, this.url, this.window, this.external);
		}
		
		override public function toString():String {
			return super.formatToString('TransitionEvent', 'type', 'url', 'window', 'external', 'eventPhase'); 
		}
	}
}