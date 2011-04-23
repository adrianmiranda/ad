package com.ad.templates {
	import com.ad.events.TransitionEvent;
	
	[Event(name = 'TransitionEvent.TRANSITION_IN', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_IN_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	[Event(name = 'TransitionEvent.TRANSITION_OUT_COMPLETE', type = 'com.ad.events.TransitionEvent')]
	
	/**
	 * @author Adrian Miranda
	 */
	public class Viewer extends Base {
		
		public function Viewer(resizable:Boolean = false) {
			super(resizable);
		}
		
		public function transitionIn():void {
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN));
		}
		
		public function transitionOut():void {
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT));
		}
		
		public function transitionInComplete():void {
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE));
		}
		
		public function transitionOutComplete():void {
			super.dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE));
		}
		
		override public function toString():String {
			return '[Viewer ' + super.name + ']';
		}
	}
}
