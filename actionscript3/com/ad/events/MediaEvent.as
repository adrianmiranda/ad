package com.ad.events {
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class MediaEvent extends Event {
		public static const CUE_POINT:String = 'MediaEvent.onCuePoint';
		public static const STREAM_NOT_FOUND:String = 'NetStream.Play.StreamNotFound';
		public static const BUFFER_FULL:String = 'NetStream.Buffer.Full';
		public static const BUFFER_EMPTY:String = 'NetStream.Buffer.Empty';
		public static const COMPLETE:String = 'NetStream.Play.Stop';
		
		protected var _target:Object;
		protected var _ready:Boolean;
		
		public var text:String;
		public var data:*;
		
		public function MediaEvent(type:String, target:Object, text:String = '', data:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, false, false);
			this._target = target;
			this.text = text;
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
		
		public override function clone():Event{
			return new MediaEvent(this.type, this._target, this.text, this.data);
		}
		
		override public function toString():String {
			return super.formatToString('MediaEvent', 'type', 'target', 'text', 'data', 'eventPhase'); 
		}
	}
}