package com.ad.templates {
	import com.ad.events.TransitionEvent;
	import com.ad.interfaces.IViewer;
	import com.ad.display.Leprechaun;
	
	[Event(name = 'TransitionEvent.TRANSITION_IN', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_IN_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class ViewerLite extends Leprechaun implements IViewer {
		public var onTransitionIn:Function;
		public var onTransitionInParams:Array;
		public var onTransitionOut:Function;
		public var onTransitionOutParams:Array;
		public var onTransitionInComplete:Function;
		public var onTransitionInCompleteParams:Array;
		public var onTransitionOutComplete:Function;
		public var onTransitionOutCompleteParams:Array;
		
		public function ViewerLite() {
			super();
		}
		
		public function transitionIn():void {
			if (this.onTransitionIn != null) {
				this.onTransitionIn.apply(super, this.onTransitionInParams);
			}
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN));
		}
		
		public function transitionOut():void {
			if (this.onTransitionOut != null) {
				this.onTransitionOut.apply(super, this.onTransitionOutParams);
			}
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT));
		}
		
		public function transitionInComplete():void {
			if (this.onTransitionInComplete != null) {
				this.onTransitionInComplete.apply(super, this.onTransitionInCompleteParams);
			}
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE));
		}
		
		public function transitionOutComplete():void {
			if (this.onTransitionOutComplete != null) {
				this.onTransitionOutComplete.apply(super, this.onTransitionOutCompleteParams);
			}
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE));
		}
		
		/*public function interruptTransition():void {
			if (this.onInterruptTransition != null) this.onInterruptTransition.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.INTERRUPT_TRANSITION));
		}
		
		public function interruptTransitionComplete():void {
			if (this.onInterruptTransitionComplete != null) this.onInterruptTransitionComplete.apply(null, null);
			super.dispatchEvent(new TransitionEvent(TransitionEvent.INTERRUPT_TRANSITION_COMPLETE));
		}*/
		
		override public function toString():String {
			return '[ViewerLite ' + super.name + ']';
		}
	}
}