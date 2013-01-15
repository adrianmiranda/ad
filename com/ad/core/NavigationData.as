package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.errors.ADError;
	import com.ad.utils.BranchUtils;
	import com.ad.proxy.nsapplication;
	import com.ad.events.ApplicationEvent;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: 
	 */
	use namespace nsapplication;
	public class NavigationData extends NavigationCore {

		public function fromHeader(header:Header):void {
			this.validateHeader(this._header = header);
			this.setStandardLanguage();
			this.setStandardView();
			super.setHistory(header.history);
			super.setTracker(header.track);
			super.setStrict(header.strict);
			super.setTitle(header.title);
		}

		override protected function startup():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath();
			if (this.isHomePage(path)) {
				super.navigateTo(this.standardView.branch, params);
			} else {
				var view:View = this.header.getView(path);
				if (view) {
					this.setView(view);
					super.setTitle(view.title);
					this.setLanguage(view.branch);
					this.stackTransition(view, params);
					super.notify(ApplicationEvent.CHANGE_VIEW);
				} else {
					super.navigateTo(this.standardView.branch, params);
				}
			}
		}
		
		override protected function externalChange():void {
			this.validateHeader(this.header);
			var value:String = BranchUtils.arrange(super.getValue());
			var suffix:String = new String();
			var lastLanguage:Language = this.language;
			var lastView:View = this.view;
			var typedLanguage:Language = this.setLanguage(value);
			var typedView:View = this.setView(value);
			if (this.view.id != this.lastView.id) {
				if (value.indexOf(this.view.id) > -1 || value.indexOf(this.view.branch) > -1) {
					suffix = value.substr(value.indexOf(this.view.branch) + this.view.branch.length, value.length);
					value = value.split(this.language.branch).join('');
					if (this.lastView.level == 1) {
						this.navigateTo(BranchUtils.arrange(this.language.branch + '/' + this.view.branch + suffix));
						return;
					}
				}
				if (this.view.id == this.mistakeView.id) {
					super.setHistory(false);
					this.navigateTo(BranchUtils.arrange(this.language.branch + '/' + this.view.branch + suffix));
					super.setHistory(this.header.history);
				}
			}
		}

		override protected function internalChange():void {
			this.validateHeader(this.header);
			var value:String = BranchUtils.arrange(super.getValue());
			this.setLanguage(value);
			this.setView(value);
		}

		override public function navigateTo(value:*, query:Object = null):void {
			this.validateHeader(this.header);
			value = BranchUtils.arrange(value);
			var section:View, suffix:String = new String();
			var params:String = BranchUtils.getQueryString(value, true);
			var path:String = BranchUtils.cleanup(value);
			this.setLanguage(path);
			path = path.split(this.language.branch).join('');
			path = this.isHomePage(path) ? this.standardView.branch : path;
			section = header.getView(path) || this.view;
			if (path.indexOf(section.branch) > -1) {
				path = BranchUtils.trimQueryString(path);
				suffix = path.substr(path.indexOf(section.branch) + section.branch.length, path.length);
			}
			super.navigateTo(BranchUtils.arrange(language.branch + '/' + section.branch + suffix + params), query);
		}

		public function setLanguage(value:*):Language {
			var locale:Language;
			if (value) {
				this.validateHeader(this.header);
				locale = this.lang::get(value);
				if (locale) {
					locale = locale.tree;
					if (locale.branch != language.branch) {
						this._lastLanguage = this._language;
						this._language = locale;
						super.notify(ApplicationEvent.CHANGE_LANGUAGE);
					}
				} else {
					super.setHistory(false);
					super.navigateTo(BranchUtils.arrange(this.language.branch + '/' + this.view.branch));
					super.setHistory(this.header.history);
				}
			}
			return locale;
		}

		public function setView(value:*):View {
			var section:View;
			if (value) {
				this.validateHeader(this.header);
				if (value is String) {
					value = BranchUtils.arrange(value);
					value = this.isHomePage(value) ? this.standardView.branch : value;
					value = value.split(this.language.branch).join('');
				}
				section = this.header.getView(value) || this.mistakeView;
				if (section) {
					var suffix:String = new String();
					if (value is String && value.indexOf(section.branch) > -1) {
						suffix = value.substr(value.indexOf(section.branch) + section.branch.length, value.length);
					}
					//if (section.branch != this.view.branch) {
						this._lastView = this._view;
						this._view = section;
						super.setTitle(this.view.title);
						this.stackTransition(this.view);
						super.notify(ApplicationEvent.CHANGE_VIEW);
					//}
				}
			}
			return section;
		}
		
		private function setStandardLanguage():void {
			this._lastLanguage = this.standardLanguage;
			this._language = this.standardLanguage;
		}

		private function setStandardView():void {
			this._lastView = this.standardView;
			this._view = this.standardView;
			super.setTitle(this.view.title);
		}



		/**
		 *
		 * HML
		 *
		 */
		view function get(value:*):View {
			return null;
		}


		/**
		 *
		 * DEV
		 *
		 */
		protected namespace lang = 'com.ad.data.Language';
		protected namespace view = 'com.ad.data.View';
		protected namespace path = 'com.ad.data';
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

		public function isHomePage(value:*):Boolean {
			this.validateHeader(this.header);
			if (value is String) {
				value = value.split(this.language.branch).join('');
				value = BranchUtils.arrange(value, false).toLowerCase();
			}
			return (value == this.view || value == this.views.root.branch || value == '/' || value == '');
		}

		lang function get(value:*):Language {
			var locale:Language = this.languages.getLanguage(value);
			if (locale && locale.standard) {
				return lang::get(locale.standard);
			}
			return locale;
		}

		path function get(value:String):* {
			var pattern:RegExp = new RegExp('(.*)('+ value +'/*$)', 'g');
			var result:Object = pattern.exec(value);
			trace(result[1]);
			trace(result[2]);
			return null;
		}

		public function get standardView():View {
			return this.header ? this.views.getView(this.views.root.standard) : null;
		}
		
		public function get mistakeView():View {
			return this.header ? this.views.getView(this.views.root.mistake) : null;
		}
		
		public function get standardLanguage():Language {
			return this.languages ? this.lang::get(this.languages.standard) : null;
		}
		
		public function get languages():Language {
			return this.header ? this.header.languages : null;
		}
		
		public function get views():View {
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
			// to override.
		}

		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				this._header = null;
				this._lastLanguage = null;
				this._language = null;
				this._lastView = null;
				this._view = null;
			}
			super.dispose(flush);
		}

		override public function toString():String {
			return '[NavigationData ' + super.apiKey + ']';
		}
	}
}