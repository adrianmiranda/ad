package com.ad.templates {
	import com.ad.core.Application;
	import com.ad.data.File;
	import com.ad.data.Language;
	import com.ad.data.View;
	import com.ad.events.ApplicationEvent;
	import com.ad.interfaces.ISection;
	import com.ad.proxy.nsapplication;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	use namespace nsapplication;
	public class SectionLite extends BaseLite implements ISection {
		private var _application:Application;
		private var _childParentView:ISection;
		private var _childView:ISection;
		
		public function SectionLite(resizable:Boolean = true, autoStartRendering:Boolean = false, margin:Rectangle = null) {
			super(resizable, autoStartRendering, margin);
		}
		
		public function set apiKey(key:String):void {
			if (!this._application) {
				this._application = Application.getInstance(key);
				this._application.addEventListener(ApplicationEvent.CHANGE_VIEW, this.onChangeView);
				this._application.addEventListener(ApplicationEvent.CHANGE_LANGUAGE, this.onChangeLanguage);
			}
		}
		
		override protected function onAddedToStage(event:Event):void {
			super.onAddedToStage(event);
			this.localize();
			this.arrange();
		}
		
		override protected function onRemovedFromStage(event:Event):void {
			super.onRemovedFromStage(event);
			if (this._application) {
				this._application.removeEventListener(ApplicationEvent.CHANGE_LANGUAGE, this.onChangeLanguage);
				this._application.removeEventListener(ApplicationEvent.CHANGE_VIEW, this.onChangeView);
				this._application = null;
			}
		}
		
		private function onChangeLanguage(event:ApplicationEvent):void {
			this.localize();
		}
		
		private function onChangeView(event:ApplicationEvent):void {
			this.change();
		}
		
		nsapplication function set childParentView(view:ISection):void {
			this._childParentView = view;
		}
		
		nsapplication function attachChildView(view:ISection):void {
			this._childView = view;
			this._childView::childParentView = this;
			super.addChild(DisplayObject(this._childView));
		}
		
		nsapplication function detachChildView():void {
			this._childView.die();
			this._childView = null;
		}
		
		public function getLanguage(id:* = 0):Language {
			return this._application.header.languages.getLanguage(id);
		}
		
		public function getView(id:* = ''):View {
			return this._application.header.views.getView(id);
		}
		
		public function getFile(id:* = 0):File {
			return this.getView(super.name).getFile(id) || this.getView().getFile(id);
		}
		
		public function getAsset(nameOrURL:String):* {
			return this._application.getContent(nameOrURL);
		}

		public function getLoader(nameOrURL:String):* {
			return this._application.getLoader(nameOrURL);
		}
		
		public function setLanguage(value:*):void {
			this._application.navigateTo(value);
		}
		
		public function navigateTo(value:*):void {
			this._application.navigateTo(value);
		}
		
		public function go(delta:int):void {
			this._application.go(delta);
		}
		
		public function forward():void {
			this._application.forward();
		}
		
		public function back():void {
			this._application.back();
		}
		
		public function clearHistory():void {
			this._application.clearHistory();
		}
		
		public function localize():void {
			// to override
		}
		
		public function change():void {
			// to override
		}
		
		public function get pathNames():Array {
			return this._application.pathNames;
		}
		
		public function get language():Language {
			return this._application.language;
		}
		
		public function get view():View {
			return this._application.view;
		}
		
		override public function toString():String {
			return '[SectionLite ' + super.name + ']';
		}
	}
}