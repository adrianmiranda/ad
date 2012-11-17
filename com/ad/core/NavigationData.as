package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.errors.ADError;
	import com.ad.utils.BranchUtils;
	
	public class NavigationData extends NavigationCore {
		private var _header:Header;
		private var _lastLanguage:Language;
		private var _language:Language;
		private var _lastView:View;
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

		public function registerViews(header:Header):void {
			this.validateHeader(this._header = header);
			this.setLanguage(this.standardLanguage);
			this.setView(this.standardView);
			super.setHistory(header.history);
			super.setTracker(header.track);
			super.setStrict(header.strict);
			super.setTitle(header.title);
		}

		public function isHomePage(value:*):Boolean {
			this.validateHeader(this.header);
			if (value && value is String) {
				//value = value.split(this.language.branch).join('');
				value = BranchUtils.arrange(value, false).toLowerCase();
			}
			return (value == this.view || value == this.views.root.branch || value == '/home/' || value == '/' || value == '');
		}

		public function createViews(xml:XML):void {
			this.registerViews(new Header(xml, null));
		}

		public function get standardView():View {
			return this.header ? this.views.getView(this.views.root.standard) : null;
		}
		
		public function get mistakeView():View {
			return this.header ? this.views.getView(this.views.root.mistake) : null;
		}
		
		public function get standardLanguage():Language {
			return this.languages ? this.languages.getLanguage(this.languages.standard) : null;
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

		public function setLanguage(value:*):Language {
			if (value) {
				this.validateHeader(this.header);
				//this._lastLanguage = this._language;
				//this._language = value;
			}
			return this._language;
		}

		public function setView(value:*):View {
			if (value) {
				this.validateHeader(this.header);
				this._lastView = this._view;
				this._view = value;
			}
			return this._view;
		}

		protected function stackTransition(view:View, params:Object = null):void {
			// to override.
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
					this.stackTransition(view, params);
				} else {
					super.navigateTo(this.standardView.branch, params);
				}
			}
		}

		override protected function change():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath() == '/' ? this.standardView.branch : super.getPath();
			var view:View = this.header.getView(path);
			if (view) {
				this.setView(view);
				this.setLanguage(view.branch);
				super.setTitle(view.title);
				this.stackTransition(view, params);
			} else {
				this.setView(this.mistakeView);
			}
		}

		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				_header = null;
				_lastLanguage = null;
				_language = null;
				_lastView = null;
				_view = null;
			}
			super.dispose(flush);
		}
	}
}