package com.ad.utils {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public final class Timeout {
		private static var activeTimeouts:Array;
		private var timer:Timer;
		private var func:Function;
		private var params:Array;
		
		public function Timeout(func:Function, delay:Number, ...params:Array) {
			if (!Timeout.activeTimeouts) {
				Timeout.activeTimeouts = new Array();
			}
			Timeout.activeTimeouts.push(this);
			this.func = func;
			this.params = params;
			this.timer = new Timer(delay, 1);
			this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this.timer.start();
		}
		
		public static function cancelAllTimeouts():void {
			var id:int = Timeout.activeTimeouts.length;
			while (id--) {
				var timeout:Timeout = Timeout(Timeout.activeTimeouts[id]);
				timeout.cancel();
			}
		}
		
		public function cancel():void {
			if (!this.timer) return;
			this.timer.stop();
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this.destroy();
		}
		
		private function onTimerComplete(event:TimerEvent = null):void {
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			if (this.params.length) this.func(this.params);
			else this.func();
			this.destroy();
		}
		
		private function destroy():void {
			Timeout.activeTimeouts.splice(Timeout.activeTimeouts.indexOf(this), 1);
			this.timer = null;
			this.func = null;
			this.params = null;
		}
	}
}