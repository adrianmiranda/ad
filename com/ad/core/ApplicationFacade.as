package com.ad.core {
	import com.ad.common.getLayer;
	import com.ad.core.Deeplink;
	import com.ad.data.Layers;
	import com.ad.data.File;
	import com.ad.data.Language;
	import com.ad.data.View;
	import com.ad.errors.ADError;
	import com.ad.events.DeeplinkEvent;
	import com.ad.events.TransitionEvent;
	import com.ad.interfaces.ISection;
	import com.ad.proxy.nsapplication;
	import com.ad.utils.Cleaner;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	use namespace nsapplication;
	public class ApplicationFacade extends ApplicationLoader {
		private var _container:DisplayObjectContainer;
		private var _sectionLayerId:String;
		private var _isInterrupted:Boolean;
		private var _transitionState:int;
		private var _section:ISection;
		
		public function ApplicationFacade(key:String = null) {
			super(key);
		}
		
		public static function getInstance(key:String = null):ApplicationFacade {
			if (!hasInstance(key)) instances[key] = new ApplicationFacade(key);
			return instances[key] as ApplicationFacade;
		}
		
		override public function startup(binding:DisplayObject = null):void {
			this.validateContainer(binding);
			super.startup(this._container = DisplayObjectContainer(binding));
		}
		
		public function run(sectionLayerId:String = null):void {
			this._sectionLayerId = sectionLayerId;
			Deeplink.registerViews(super.header);
			Deeplink.addEventListener(DeeplinkEvent.INIT, this.onInitDeeplink);
			Deeplink.addEventListener(DeeplinkEvent.CHANGE, this.onChangeDeeplink);
			Deeplink.addEventListener(DeeplinkEvent.CHANGE_VIEW, this.onChangeView);
			Deeplink.addEventListener(DeeplinkEvent.CHANGE_LANGUAGE, this.onChangeLanguage);
			Deeplink.initialize();
		}
		
		public function setTitle(value:String):void {
			Deeplink.setTitle(value);
		}
		
		public function setLanguage(value:*):void {
			Deeplink.setLanguage(value);
		}
		
		public function goto(value:*):void {
			Deeplink.setValue(value);
		}
		
		public function go(delta:int):void {
			Deeplink.go(delta);
		}
		
		public function up():void {
			Deeplink.up();
		}
		
		public function forward():void {
			Deeplink.forward();
		}
		
		public function back():void {
			Deeplink.back();
		}
		
		public function clearHistory():void {
			Deeplink.clearHistory();
		}
		
		public function get view():View {
			return Deeplink.view;
		}
		
		public function get language():Language {
			return Deeplink.language;
		}
		
		public function get pathNames():Array {
			return Deeplink.getPathNames();
		}
		
		private function makeSection(view:View):void {
			try {
				if (this._section) {
					//super.stop(true);
					this._section.transitionOut();
				} else {
					//super.prepareViewLoader(view);
					this._section = new view.caste();
					this._section.apiKey = super.apiKey;
					this._section.name = view.className.substr(view.className.lastIndexOf('.') + 1, view.className.length);
					this._section.addEventListener(TransitionEvent.TRANSITION_IN, this.onSectionTransitionIn);
					this._section.addEventListener(TransitionEvent.TRANSITION_IN_COMPLETE, this.onSectionTransitionInComplete);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT, this.onSectionTransitionOut);
					this._section.addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE, this.onSectionTransitionOutComplete);
					//this._section::attachChildView();
					if (this._sectionLayerId && Layers.shortcutTarget.hasOwnProperty(this._sectionLayerId)) {
						getLayer(this._sectionLayerId).addChild(DisplayObject(this._section));
					} else {
						this._container.addChild(DisplayObject(this._section));
					}
					this._section.transitionIn();
				}
			} catch(event:Error) {
				trace('[ApplicationFacade]::makeSection:', event.message);
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
			TweenMax.killTweensOf(this._section);
			TweenMax.killChildTweensOf(DisplayObjectContainer(this._section));
			TweenMax.killDelayedCallsTo(this._section);
			TweenLite.killTweensOf(this._section);
			TweenLite.killDelayedCallsTo(this._section);
			this._section.die();
			this._section = null;
			Cleaner.gc();
			this.makeSection(Deeplink.view);
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
		
		protected function onInitDeeplink(event:DeeplinkEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeDeeplink(event:DeeplinkEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeView(event:DeeplinkEvent):void {
			this.makeSection(Deeplink.view);
			super.dispatchEvent(event.clone());
		}
		
		protected function onChangeLanguage(event:DeeplinkEvent):void {
			super.dispatchEvent(event.clone());
		}
		
		public function get container():DisplayObjectContainer {
			return this._container;
		}
		
		public function get stage():Stage {
			return this.container ? this.container.stage : null;
		}
		
		private function validateContainer(binding:DisplayObject):void {
			var error:String = '*Startup Failed* Binding ';
			if (!binding) {
				throw new ADError(error + 'missing required');
			}
			else if (!binding.hasOwnProperty('stage')) {
				throw new ADError(error + 'missing required property \'stage\'');
			}
			else if (!binding.stage) {
				throw new ADError(error + 'missing required being on stage');
			}
		}
		
		override public function dispose(flush:Boolean = false):void {
			Deeplink.dispose(flush);
			if (flush) {
				this._container = null;
			}
			super.dispose(flush);
		}
		
		override public function toString():String {
			return '[ApplicationFacade ' + super.apiKey + ']';
		}
	}
}