package com.ad.core.events {
	import com.ad.core.data.View;
	
	import flash.events.Event;
	
	public final class ApplicationEvent extends Event {
		public static const CHANGE:String = 'ApplicationEvent.CHANGE';
		private var _view:View;
		
		public function ApplicationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function get view():View {
			return this._view;
		}
		
		override public function get currentTarget():Object {
			return super.currentTarget;
		}
		
		override public function get target():Object {
			return super.target;
		}
		
		override public function clone():Event {
			return new ApplicationEvent(super.type, super.bubbles, super.cancelable);
		}
	}
}