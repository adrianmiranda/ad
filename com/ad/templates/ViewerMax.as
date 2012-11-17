package com.ad.templates {
	import com.ad.events.TransitionEvent;
	import com.ad.interfaces.IViewer;
	import com.ad.display.Cluricaun;
	
	[Event(name = 'TransitionEvent.TRANSITION_IN', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_IN_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	
	public class ViewerMax extends Cluricaun implements IViewer {
		public var onTransitionIn:Function;
		public var onTransitionOut:Function;
		public var onTransitionInComplete:Function;
		public var onTransitionOutComplete:Function;
		
		public function ViewerMax() {
			super();
		}
		
		public function transitionIn():void {
			if (this.onTransitionIn != null) this.onTransitionIn.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN));
		}
		
		public function transitionOut():void {
			if (this.onTransitionOut != null) this.onTransitionOut.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT));
		}
		
		public function transitionInComplete():void {
			if (this.onTransitionInComplete != null) this.onTransitionInComplete.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE));
		}
		
		public function transitionOutComplete():void {
			if (this.onTransitionOutComplete != null) this.onTransitionOutComplete.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE));
		}
		
		override public function toString():String {
			return '[ViewerMax ' + super.name + ']';
		}
	}
}