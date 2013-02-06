package com.ad.data {
	import com.ad.common.bool;
	import com.ad.utils.Binding;
	import com.ad.errors.ADError;
	import com.ad.utils.BranchUtils;
	
	import __AS3__.vec.Vector;
	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br> 
	 */
	public final class Language {
		internal namespace nsarmored = 'www.adrianmiranda.com.br/com/adframework/core/data/language.nsarmored';
		private static var LIST:Vector.<Language> = new Vector.<Language>();
		private static var BRANCH:String = new String();
		private static var INDEX:uint;
		private var _index:int;
		private var _branch:String;
		private var _languages:Vector.<Language>;
		private var _binding:DisplayObject;
		private var _parent:Language;
		private var _standard:String;
		private var _track:String;
		private var _level:uint;
		private var _id:String;
		private var _node:XML;
		
		public function Language(xml:XML, binding:DisplayObject = null) {
			this.validateLanguage(xml);
			this._binding = binding;
			this._index = ++INDEX;
			this._node = xml;
			this._id = xml.@id;
			this._track = xml.@track;
			if (this._index) {
				this._branch = BRANCH += BranchUtils.lputSlash(BranchUtils.cleanup(this.id));
				LIST.push(this);
			} else {
				this._branch = BranchUtils.lputSlash(BranchUtils.cleanup(this.id));
			}
			this._branch = BranchUtils.arrange(this._branch);
			this._level = BranchUtils.getLevel(this._branch);
			if (xml.hasOwnProperty('language')) {
				this.validateLanguage(xml.language[0]);
				this.validateLanguages(xml);
				this._standard = xml.language.length() > 1 ? xml.@standard : xml.language[0].@id;
				this._standard = BranchUtils.arrange(this.branch + '/' + this._standard);
				this._languages = new Vector.<Language>();
				for each (var child:XML in xml.children()) {
					if (child.@enabled != undefined ? !bool(child.@enabled) : false) continue;
					var language:Language = new Language(child, this._binding);
					language.nsarmored::parent = this;
					this._languages.push(language);
				}
			}
			BRANCH = BranchUtils.trimLastLevel(BRANCH);
		}
		
		private function validateLanguages(node:XML):void {
			var error:String = '*Invalid Languages XML* Complex language ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (node.language.length() > 1 && node.@standard == undefined) {
				throw new ADError(error + node.@id + ' node missing required attribute \'standard\'');
			}
			else if (node.@standard != undefined && !node.language.(@id == node.@standard).length()) {
				throw new ADError(error + node.@id + ' \'standard\' node missing');
			}
			else if (node.(descendants('language').@id.contains(node.@id)).length()) {
				throw new ADError(error + node.@id + ' node duplicate');
			}
		}
		
		private function validateLanguage(node:XML):void {
			var error:String = '*Invalid Languages XML* Language ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (INDEX > 0 && node.@id == undefined) {
				throw new ADError(error + 'node missing required attribute \'id\'');
			}
			else if (INDEX > 0 && !/^([a-zA-Z0-9-_])+$/g.test(node.@id)) {
				throw new ADError(error + node.@id + ' \'id\' attribute contains invalid characters');
			}
		}
		
		private function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}
		
		public function get root():Language {
			var language:Language = this;
			while (language.parent) {
				language = language.parent;
			}
			return language;
		}
		
		public function get tree():Language {
			var language:Language = this;
			while (language.standard) {
				language = language.getLanguage(language.standard);
			}
			return language;
		}
		
		public function getLanguage(value:* = 0):Language {
			if (value is String) value = BranchUtils.arrange(value);
			if (value == this) return this;
			if (BranchUtils.cleanup(value) == this.id) return this;
			if (value == this.node) return this;
			if (value == this.index) return this;
			if (value == this.branch) return this;
			if (this.hasLanguages) {
				if (this.languages.hasOwnProperty(value)) {
					return this.languages[value];
				}
				for (var id:uint; id < this.languages.length; id++) {
					var language:Language = this.languages[id];
					if (language) {
						language = language.getLanguage(value);
						if (language) {
							return language;
						}
					}
				}
			}
			var re:RegExp = new RegExp('^('+ this.branch +').*$');
			if (this.branch && value is String && re.test(value)) {
				var matches:Array = re.exec(value);
				if (matches && matches.length) {
					return this.getLanguage(matches[1]);
				}
			}
			return null;
		}
		
		public function get hasLanguages():Boolean {
			if (!this._languages) return false;
			return this._languages.length > 0;
		}
		
		public function get list():Vector.<Language> {
			return LIST;
		}

		public function get languages():Vector.<Language> {
			return this._languages;
		}
		
		public function get binding():DisplayObject {
			return this._binding;
		}
		
		nsarmored function set parent(value:Language):void {
			this._parent = value;
		}
		
		public function get parent():Language {
			return this._parent;
		}
		
		public function get track():String {
			return this._track;
		}
		
		public function get standard():String {
			return this._standard;
		}
		
		public function get branch():String {
			return this._branch;
		}
		
		public function get level():uint {
			return this._level;
		}
		
		public function get index():int {
			return this._index - 1;
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function get node():XML {
			return this._node;
		}
		
		public function dispose():void {
			if (this.hasLanguages) {
				var id:uint = this._languages.length;
				while (id--) {
					this._languages[id].dispose();
					this._languages.splice(id, 1);
				}
				this._languages = null;
			}
			LIST = new Vector.<Language>();
			BRANCH = new String();
			INDEX = 0;
			this._standard = null;
			this._binding = null;
			this._parent = null;
			this._branch = null;
			this._track = null;
			this._node = null;
			this._id = null;
		}
		
		public function toString():String {
			if (this.id) return '[Language ' + this.id + ']';
			return '[Languages]';
		}
	}
}