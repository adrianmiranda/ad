package com.ad.events {
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class Note extends Event {
		/** @Animation */
		public static const ANIMATION_IN:String = 'Note.ANIMATION_IN';
		public static const ANIMATION_IN_COMPLETE:String = 'Note.ANIMATION_IN_COMPLETE';
		public static const ANIMATION_OUT:String = 'Note.ANIMATION_OUT';
		public static const ANIMATION_OUT_COMPLETE:String = 'Note.ANIMATION_OUT_COMPLETE';
		
		/** @Utils */
		public static const OPEN:String = 'Note.OPEN';
		public static const CLOSE:String = 'Note.CLOSE';
		public static const ACTIVATE:String = 'Note.ACTIVATE';
		public static const DEACTIVATE:String = 'Note.DEACTIVATE';
		public static const UPDATE:String = 'Note.UPDATE';
		public static const CHANGE:String = 'Note.CHANGE';
		public static const SELECT:String = 'Note.SELECT';
		public static const SELECT_ALL:String = 'Note.SELECT_ALL';
		public static const INIT:String = 'Note.INIT';
		public static const ADDED:String = 'Note.ADDED';
		public static const CLEAR:String = 'Note.CLEAR';
		public static const UNLOAD:String = 'Note.UNLOAD';
		public static const CANCEL:String = 'Note.CANCEL';
		public static const COMPLETE:String = 'Note.COMPLETE';
		public static const SOUND_COMPLETE:String = 'Note.SOUND_COMPLETE';
		public static const SEARCH:String = 'Note.SEARCH';
		public static const SEARCH_COMPLETE:String = 'Note.SEARCH_COMPLETE';
		public static const REFRESH:String = 'Note.REFRESH';
		
		protected var _target:Object;
		protected var _ready:Boolean;
		
		public var data:Object;
		
		public function Note(type:String, target:Object, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._target = target;
			this.data = data;
		}
		
		override public function get target():Object {
			if (this._ready) {
				return this._target;
			} else {
				this._ready = true;
			}
			return null;
		}
		
		override public function clone():Event {
			return new Note(this.type, this.data, super.bubbles, super.cancelable);
		}
		
		override public function toString():String {
			return super.formatToString('Note', 'type', 'target', 'data', 'eventPhase'); 
		}
	}
}