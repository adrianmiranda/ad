package com.ad.core {
	import com.ad.data.Language;
	import com.ad.data.View;
	import com.ad.utils.Cleaner;
	import com.ad.events.TransitionEvent;
	import com.ad.interfaces.ISection;
	import com.ad.proxy.nsapplication;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > TODO: Subsections manager
	 */
	use namespace nsapplication;
	public final class Navigation extends NavigationData {
		private var _isInterrupted:Boolean;
		private var _transitionState:int;
		private var _section:ISection;

		public function Navigation(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):Navigation {
			if (!hasInstance(key)) instances[key] = new Navigation(key);
			return instances[key] as Navigation;
		}

		public static function classes(...rest:Array):void {
			// no need to do anything - we just want to force the classes to get compiled in the swf.
		}

		override protected function stackTransition(view:View, params:Object = null):void {
			try {
				//trace('flow:', super.header.flow);
				if (this._section) {
					//super.stop(true);
					this._section.transitionOut();
				} else {
					//super.prepareViewLoader(view);
					this._section = new view.caste();
					this._section.apiKey = super.apiKey;
					this._section.name = view.className;
					this._section.addEventListener(TransitionEvent.TRANSITION_IN, this.onSectionTransitionIn);
					this._section.addEventListener(TransitionEvent.TRANSITION_IN_COMPLETE, this.onSectionTransitionInComplete);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT, this.onSectionTransitionOut);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE, this.onSectionTransitionOutComplete);
					//this._section::attachChildView();
					super.container.addEventListener(Event.ADDED, onSectionAdded);
					super.container.addChild(DisplayObject(this._section));
				}
			} catch(event:Error) {
				trace('[ApplicationFacade]::stackTransition:', event.message);
			}
		}

		private function onSectionAdded(event:Event):void {
			super.container.removeEventListener(Event.ADDED, onSectionAdded);
			this._section.transitionIn();
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
			TweenMax.killTweensOf(this._section);
			TweenMax.killChildTweensOf(DisplayObjectContainer(this._section));
			TweenMax.killDelayedCallsTo(this._section);
			TweenLite.killTweensOf(this._section);
			TweenLite.killDelayedCallsTo(this._section);
			this._section.die();
			this._section = null;
			Cleaner.gc();
			this.stackTransition(super.view);
		}
		
		private function onInterruptTransition():void {
			var transitionDirection:String = new String();
			if (this._transitionState & 1) transitionDirection = 'IN';
			if (this._transitionState & 2) transitionDirection += 'OUT';
			if (transitionDirection == 'INOUT') transitionDirection = 'CROSS';
			trace('>>> INTERRUPT ' + transitionDirection + ' <<<');
			TweenMax.to(this._section, 0.3, { alpha:0, onComplete:this.killSection, overwrite:0 } );
		}

		public function get section():ISection {
			return this._section;
		}

		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				if (this._section) {
					this._section.die();
					this._section = null;
				}
			}
			super.dispose(flush);
		}
		
		override public function toString():String {
			return '[Navigation ' + super.apiKey + ']';
		}
	}
}