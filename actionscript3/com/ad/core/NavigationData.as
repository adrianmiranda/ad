package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.errors.ADError;
	import com.ad.utils.BranchUtils;
	import com.ad.proxy.nsapplication;
	import com.ad.events.ApplicationEvent;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > TODO: Corrigir leitura de prefixo para view
	 */
	use namespace nsapplication;
	public class NavigationData extends NavigationCore {
		public namespace i18n = 'com.ad.data.Language';
		public namespace area = 'com.ad.data.View';
		private var _lastLanguage:Language;
		private var _language:Language;
		private var _lastView:View;
		private var _header:Header;
		private var _view:View;

		public function NavigationData(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):NavigationData {
			if (!hasInstance(key)) instances[key] = new NavigationData(key);
			return instances[key] as NavigationData;
		}

		protected function validateHeader(header:Header):void {
			var error:String = '*NavigationData* Header ';
			if (header == null) {
				throw new ADError(error + 'missing required');
			}
			else if (!header.hasViews) {
				throw new ADError(error + 'there is no node view');
			}
		}

		public function fromXML(xml:XML):void {
			this.fromHeader(new Header(xml, null));
		}

		public function fromHeader(header:Header):void {
			this.validateHeader(this._header = header);
			super.setHistory(header.history);
			super.setTracker(header.track);
			super.setStrict(header.strict);
			super.setTitle(header.title);
		}

		override protected function init():void {
			this.validateHeader(this.header);
			this.navigateTo(super.getValue(), super.parameters);
		}

		override protected function startup():void {
			this.validateHeader(this.header);
			this.calculate();
		}
		
		override public function navigateTo(value:*, query:Object = null):void {
			this.validateHeader(this.header);
			var qs:String = value is String ? super.getQueryString(value) : '';
			var language:Language = this.i18n::get(value);
			var view:View = this.area::get(value);
			super.setHistory(view.history);
			super.navigateTo(language.branch +'/'+ view.branch + qs, query);
			super.setHistory(header.history);
		}

		override protected function externalChange():void {
			this.validateHeader(this.header);
		}

		override protected function internalChange():void {
			this.validateHeader(this.header);
		}
		
		override protected function change():void {
			this.validateHeader(this.header);
			this.calculate();
		}

		public function calculate(value:* = null):Boolean {
			this.validateHeader(this.header);
			value ||= super.getValue() || super.getPath();
			var language:Language = this.i18n::get(value);
			var view:View = this.area::get(value);
			if (this.base && this.base.views) {
				if (this.area::set(view) || this.i18n::set(language)) {
					this.navigateTo(language.branch +'/'+ view.branch, super.parameters);
					super.notify(ApplicationEvent.CHANGE);
				}
				return true;
			}
			return false;
		}

		i18n function set(value:* = null):Language {
			this.validateHeader(this.header);
			value = this.i18n::get(value);
			if (value != this._lastLanguage) {
				this._lastLanguage = this._language || value;
				this._language = value;
				super.notify(ApplicationEvent.CHANGE_LANGUAGE);
				return value;
			}
			return null;
		}

		area function set(value:* = null):View {
			this.validateHeader(this.header);
			value = this.area::get(value);
			if (value != this._lastView) {
				this._lastView = this._view || value;
				this._view = value;
				super.setTitle(value.title || this.header.title);
				this.stackTransition(value, super.parameters);
				super.notify(ApplicationEvent.CHANGE_VIEW);
				return value;
			}
			return null;
		}

		i18n function get(value:* = null):Language {
			this.validateHeader(this.header);
			var language:Language = this.languages;
			if (language) {
				language = language.getLanguage(value);
				if (language && language.standard) {
					return i18n::get(language.standard);
				} else if (!language) {
					return this.standardLanguage;
				}
			}
			return language;
		}

		area function get(value:* = null):View {
			this.validateHeader(this.header);
			var view:View = this.base;
			if (view && view.views) {
				view = view.getView(value);
				if (view && view.standard) {
					return this.area::get(view.standard);
				} else if (!view) {
					return this.mistakeView;
				}
			}
			return view;
		}

		public function get standardView():View {
			return this.area::get(this.base.root.standard);
		}
		
		public function get mistakeView():View {
			return this.area::get(this.base.root.mistake);
		}
		
		public function get standardLanguage():Language {
			return this.i18n::get(this.languages.standard);
		}
		
		public function get languages():Language {
			return this.header ? this.header.languages : null;
		}
		
		public function get base():View {
			return this.header ? this.header.views : null;
		}

		public function get header():Header {
			return this._header;
		}
		
		public function get lastLanguage():Language {
			return this._lastLanguage;
		}

		public function get language():Language {
			return this._language;
		}
		
		public function get lastView():View {
			return this._lastView;
		}
		
		public function get view():View {
			return this._view;
		}

		protected function stackTransition(view:View, params:Object = null):void {
			// to override
		}
		
		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				this._lastLanguage = null;
				this._language = null;
				this._lastView = null;
				this._header = null;
				this._view = null;
			}
			super.dispose(flush);
		}

		override public function toString():String {
			return '[NavigationData ' + super.apiKey + ']';
		}
	}
}