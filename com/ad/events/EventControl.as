package com.ad.events {
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class EventControl implements IEventDispatcher {
		private var _types:Vector.<String> = new Vector.<String>();
		private var _listeners:Vector.<Function> = new Vector.<Function>();
		private var _dispatcher:IEventDispatcher;
		
		public function EventControl(target:IEventDispatcher = null) {
			this._dispatcher = new EventDispatcher(target);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					return;
				}
			}
			this._types.push(type);
			this._listeners.push(listener);
			this._dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					this._types.splice(id, 1);
					this._listeners.splice(id, 1);
					this._dispatcher.removeEventListener(type, listener, useCapture);
				}
			}
		}
		
		public function removeAllEventListener():void {
			var numTypes:int = this._types.length;
			if (numTypes) {
				var id:int = numTypes;
				while (id--) {
					this._dispatcher.removeEventListener(this._types[id], this._listeners[id]);
					this._types.splice(id, 1);
					this._listeners.splice(id, 1);
				}
				this._types = new Vector.<String>();
				this._listeners = new Vector.<Function>();
			}
		}
		
		public function dispatchEvent(event:Event):Boolean {
			return this._dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean {
			return this._dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean {
			return this._dispatcher.willTrigger(type);
		}
		
		public function toString():String {
			return '[EventControl ' + this._dispatcher + ']';
		}
	}
}