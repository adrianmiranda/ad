<<<<<<< HEAD
package com.ad.events {
	import com.ad.data.Language;
	import com.ad.data.View;
=======
package com.ad.core.events {
	import com.ad.core.data.View;
>>>>>>> 6d24762ad105ee7f06a1f61f06a3ac62b339d17f
	
	import flash.events.Event;
	
	public final class ApplicationEvent extends Event {
<<<<<<< HEAD
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
=======
		public static const CHANGE:String = 'ApplicationEvent.CHANGE';
		private var _view:View;
		
		public function ApplicationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
>>>>>>> 6d24762ad105ee7f06a1f61f06a3ac62b339d17f
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
<<<<<<< HEAD
			return new ApplicationEvent(
				  super.type
				, this.apiKey
				, super.bubbles
				, super.cancelable
			);
=======
			return new ApplicationEvent(super.type, super.bubbles, super.cancelable);
>>>>>>> 6d24762ad105ee7f06a1f61f06a3ac62b339d17f
		}
	}
}