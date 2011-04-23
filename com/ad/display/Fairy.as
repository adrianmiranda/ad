package com.ad.display {
	
	dynamic public class Fairy extends Cluricaun {
		private var _types:Vector.<String> = new Vector.<String>();
		private var _listeners:Vector.<Function> = new Vector.<Function>();
		
		public function Fairy() {
			super();
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					return;
				}
			}
			this._types.push(type);
			this._listeners.push(listener);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					this._types.splice(id, 1);
					this._listeners.splice(id, 1);
					super.removeEventListener(type, listener, useCapture);
				}
			}
		}
		
		public function removeAllEventListener():void {
			var id:int = this._types.length;
			while (id--) {
				super.removeEventListener(this._types[id], this._listeners[id]);
				this._types.splice(id, 1);
				this._listeners.splice(id, 1);
			}
		}
		
		override public function die():void {
			super.die();
			this.removeAllEventListener();
			
			// TODO: implementar de forma que mate as variáveis sem afetar futuros usos do objeto Fairy
			//this._listeners = null;
			//this._types = null;
		}
		
		override public function toString():String {
			return '[Fairy ' + super.name + ']';
		}
	}
}