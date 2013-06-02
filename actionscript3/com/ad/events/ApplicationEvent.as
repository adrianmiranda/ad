package com.ad.events {
	import com.ad.data.Language;
	import com.ad.data.View;
	
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * TODO: 
	 */
	public final class ApplicationEvent extends Event {
		public static const EXTERNAL_CHANGE:String = 'ApplicationEvent.EXTERNAL_CHANGE';
		public static const INTERNAL_CHANGE:String = 'ApplicationEvent.INTERNAL_CHANGE';
		public static const CHANGE_LANGUAGE:String = 'ApplicationEvent.CHANGE_LANGUAGE';
		public static const CHANGE_VIEW:String = 'ApplicationEvent.CHANGE_VIEW';
		public static const STARTUP:String = 'ApplicationEvent.STARTUP';
		public static const CHANGE:String = 'ApplicationEvent.CHANGE';
		public static const INIT:String = 'ApplicationEvent.INIT';
		private var _apiKey:String;
		private var _language:Language;
		private var _view:View;
		
		public function ApplicationEvent(type:String, apiKey:String = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._apiKey = apiKey;
		}

		public function get apiKey():String {
			return this._apiKey;
		}

		public function get language():Language {
			return this._language;
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
			return new ApplicationEvent(
				  super.type
				, this.apiKey
				, super.bubbles
				, super.cancelable
			);
		}
	}
}