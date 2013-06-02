package com.ad.utils {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public final class Timeout {
		private static var activeTimeouts:Array;
		private var _timer:Timer;
		private var _method:Function;
		private var _params:Array;
		
		public function Timeout(method:Function, delay:Number, ...params:Array) {
			if (!Timeout.activeTimeouts) {
				Timeout.activeTimeouts = new Array();
			}
			Timeout.activeTimeouts.push(this);
			this._method = method;
			this._params = params;
			this._timer = new Timer(delay, 1);
			this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this._timer.start();
		}
		
		public static function cancelAllTimeouts():void {
			var id:int = Timeout.activeTimeouts.length;
			while (id--) {
				var timeout:Timeout = Timeout(Timeout.activeTimeouts[id]);
				timeout.cancel();
			}
		}
		
		public function cancel():void {
			if (!this._timer) return;
			this._timer.stop();
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this.destroy();
		}
		
		private function onTimerComplete(event:TimerEvent = null):void {
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			if (this._params.length) this._method(this._params);
			else this._method();
			this.destroy();
		}
		
		private function destroy():void {
			Timeout.activeTimeouts.splice(Timeout.activeTimeouts.indexOf(this), 1);
			this._timer = null;
			this._method = null;
			this._params = null;
		}
	}
}