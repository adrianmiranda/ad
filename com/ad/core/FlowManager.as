package com.ad.core {
	import com.ad.interfaces.ISection;
	import com.ad.events.TransitionEvent;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public final class FlowManager {
		private var _isInterrupted:Boolean;
		private var _transitionState:int;
		private var _section:ISection;
		
		public function FlowManager() {
			
		}
		
		public function createStackTransition():void {
			this.makeSection(DeepLink.item.source);
		}
		
		private function makeSection(definition:String):void {
			try {
				if (this._section) {
					this._section.transitionOut();
				} else {
					var section:Class = getDefinitionByName(definition) as Class;
					this._section = new section();
					this._section.name = definition.substr(definition.lastIndexOf('.') + 1, definition.length);
					this._section.addEventListener(TransitionEvent.TRANSITION_IN, this.onSectionTransitionIn);
					this._section.addEventListener(TransitionEvent.TRANSITION_IN_COMPLETE, this.onSectionTransitionInComplete);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT, this.onSectionTransitionOut);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE, this.onSectionTransitionOutComplete);
					this._sectionHolder = (this._sectionHolder || getLayer(DeepLink.item.layer));
					this._section.transitionIn();
					this._sectionHolder.addChild(this._section);
					super.dispatchEvent(new Event(Event.CHANGE));
			} catch(event:Error) {
				trace('[SectionLiteManager]::makeSection:', event.message);
			}
		}
		
		private function onSectionTransitionIn(event:TransitionEvent):void {
			if (this._section) this._section.removeEventListener(TransitionEvent.TRANSITION_IN, this.onSectionTransitionIn);
			this._transitionState |= 1;
			this._isInterrupted = true;
		}
		
		private function onSectionTransitionInComplete(event:TransitionEvent):void {
			if (this._section) this._section.removeEventListener(TransitionEvent.TRANSITION_IN_COMPLETE, this.onSectionTransitionInComplete);
			this._transitionState &= 2;
			this._isInterrupted = false;
		}
		
		private function onSectionTransitionOut(event:TransitionEvent):void {
			if (this._section) this._section.removeEventListener(TransitionEvent.TRANSITION_OUT, this.onSectionTransitionOut);
			this._transitionState |= 2;
			this._isInterrupted = true;
		}
		
		private function onSectionTransitionOutComplete(event:TransitionEvent):void {
			if (this._section) this.killSection();
		}
		
		private function killSection():void {
			this._transitionState &= 1;
			this._isInterrupted = false;
			TweenLite.killTweensOf(this._section);
			TweenLite.killDelayedCallsTo(this._section);
			TweenMax.killTweensOf(this._section);
			TweenMax.killChildTweensOf(this._section);
			TweenMax.killDelayedCallsTo(this._section);
			this._section.die();
			this._section = null;
			this.makeSection(DeepLink.item.source);
		}
		
		private function onInterruptTransition():void {
			var transitionDirection:String = new String();
			if (this._transitionState & 1) transitionDirection = 'IN';
			if (this._transitionState & 2) transitionDirection += 'OUT';
			if (transitionDirection == 'INOUT') transitionDirection = 'CROSS';
			trace('>>> INTERRUPT ' + transitionDirection + ' <<<');
			TweenMax.to(_section, 0.3, { alpha:0, onComplete:this.killSection, overwrite:0 } );
		}
		
		public function get currentSection():ISection {
			return this._section;
		}
		
		public function push():void {
			
		}
		
		public function hasNext():void {
			
		}
		
		public function executeNext():void {
			
		}
		
		public function reset():void {
			
		}
	}
}