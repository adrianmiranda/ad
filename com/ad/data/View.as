package com.ad.data {
	import com.ad.common.bool;
	import com.ad.utils.Binding;
	import com.ad.utils.BranchUtils;
	import com.ad.errors.ADError;
	
	import __AS3__.vec.Vector;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 > TODO: Identificar uma sessão qualquer pelo branch na propriedade standard.
	 */
	public final class View {
		internal namespace nsarmored = 'http://www.adrianmiranda.com.br/com/adframework/core/data/view.nsarmored';
		private static var LIST:Vector.<View> = new Vector.<View>();
		private static var BRANCH:String = new String();
		private static var INDEX:uint;
		private var _caste:Class;
		private var _index:uint;
		private var _branch:String;
		private var _parent:View;
		private var _views:Vector.<View>;
		private var _files:Vector.<File>;
		private var _binding:DisplayObject;
		private var _standard:String;
		private var _mistake:String;
		private var _layer:String;
		private var _class:String;
		private var _history:Boolean;
		private var _track:String;
		private var _title:String;
		private var _level:uint;
		private var _id:String;
		private var _node:XML;
		
		public function View(xml:XML, binding:DisplayObject = null) {
			this.validateViewNode(xml);
			this._binding = binding;
			this._index = INDEX++;
			this._node = xml;
			this._id = xml.@id;
			this._history = xml.@history == undefined ? true : bool(xml.@history);
			this._track = xml.@track;
			this._layer = xml.@layer;
			this._title = xml.@title;
			this._class = xml.attribute('class');
			this._caste = getDefinitionByName(this._class) as Class;
			if (this._index) {
				this._branch = BRANCH += BranchUtils.lputSlash(BranchUtils.cleanup(this.id));
				LIST.push(this);
			} else {
				this._branch = BranchUtils.lputSlash(BranchUtils.cleanup(this.id));
			}
			this._branch = BranchUtils.cleanup(this._branch);
			this._level = BranchUtils.getLevel(this._branch);
			if (xml.hasOwnProperty('file')) {
				this._files = this.parseFiles(xml, view);
			}
			if (xml.hasOwnProperty('view')) {
				this.validateViewNode(xml.view[0]);
				this.validateBaseNode(xml);
				if (xml.@enabled != undefined ? !bool(xml.@enabled) : false) return;
				this._standard = xml.view.length() > 1 ? xml.@standard : xml.view[0].@id;
				this._mistake = xml.@mistake;
				this._views = new Vector.<View>();
				for each (var child:XML in xml.elements('view')) {
					if (child.@enabled != undefined ? !bool(child.@enabled) : false) continue;
					var view:View = new View(child as XML, binding);
					view.nsarmored::parent = this;
					this._views.push(view);
				}
			}
			BRANCH = BranchUtils.trimLastLevel(BRANCH);
		}
		
		private function validateViewNode(node:XML):void {
			var error:String = '*Invalid Views XML* View ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (node.@id == undefined) {
				throw new ADError(error + 'node missing required attribute \'id\'');
			}
			else if (!/^([a-zA-Z0-9-_])+$/g.test(node.@id)) {
				throw new ADError(error + node.@id + ' \'id\' attribute contains invalid characters');
			}
			else if (node.@['class'] == undefined) {
				throw new ADError(error + node.@id + ' node missing required attribute \'class\'');
			}
			else if ((bool(node.@menu) || bool(node.@landing)) && (node.@title == undefined || !node.@title.length)) {
				throw new ADError(error + node.@id + ' missing required attribute \'title\'');
			}
			else if (node.@window != undefined && !BranchUtils.isValidWindow(node.@window)) {
				throw new ADError(error + node.@id + ' \'window\' attribute contains invalid target \'' + node.@window + '\'');
			}
			else if (node.(descendants('view').@id.contains(node.@id)).length()) {
				throw new ADError(error + node.@id + ' node duplicate');
			}
		}
		
		private function validateBaseNode(node:XML):void {
			var error:String = '*Invalid Views XML* ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (node.view.length() > 1 && node.@standard == undefined) {
				throw new ADError(error + node.@id + ' node missing required attribute \'standard\'');
			}
			else if (INDEX == 1 && node.@mistake == undefined) {
				throw new ADError(error + node.@id + ' node missing required attribute \'mistake\'');
			}
			else if (node.@standard != undefined && !node.view.(@id == node.@standard).length()) {
				throw new ADError(error + node.@id + ' \'standard\' node missing');
			}
			else if (INDEX == 1 && !node.view.(@id == node.@mistake).length()) {
				throw new ADError(error + node.@id + ' \'mistake\' node missing');
			}
		}
		
		private function parseFiles(list:XML, parent:View):Vector.<File> {
			var fileList:Vector.<File> = new Vector.<File>();
			for each (var child:XML in list.file) {
				var file:File = new File(child, this._binding);
				file.parent = parent;
				fileList.push(file);
			}
			return fileList;
		}
		
		public function getView(value:* = ''):View {
			var view:View;
			var indexBranch:int;
			if (value is String) value = BranchUtils.cleanup(value);
			if (value == this) return this;
			if (value == this.id) return this;
			if (value == this.node) return this;
			if (value == this.index) return this;
			if (value == this.branch) return this;
			if (value == this.className) return this;
			if (this.hasViews) {
				for (var id:int; id < this.views.length; id++) {
					view = this.views[id];
					if (view) {
						view = view.getView(value);
						if (view) {
							return view;
						}
					}
				}
			}
			if (value is String && this.branch && value.indexOf(this.branch) > -1) {
				return this.getView(value.substr(value.indexOf(this.branch), this.branch.length));
			}
			return null;
		}
		
		public function getFile(value:* = 0):File {
			if (this.hasFiles) {
				if (this.files.hasOwnProperty(value)) {
					return this.files[value];
				}
				for (var id:int; id < this.files.length; id++) {
					var file:File = this.files[id];
					if (value == file.id) {
						return file;
					}
				}
			}
			return null;
		}
		
		public function get root():View {
			var view:View = this;
			while (view.parent) {
				view = view.parent;
			}
			return view;
		}
		
		public function get tree():View {
			var view:View = this;
			while (view.standard) {
				view = view.getView(view.standard);
			}
			return view;
		}
		
		public function get hasViews():Boolean {
			if (!this._views) return false;
			return this._views.length > 0;
		}
		
		public function get hasFiles():Boolean {
			if (!this._files) return false;
			return this._files.length > 0;
		}
		
		public function get index():uint {
			return this._index;
		}
		
		public function get caste():Class {
			return this._caste;
		}
		
		public function get binding():DisplayObject {
			return this._binding;
		}

		public function get list():Vector.<View> {
			return LIST;
		}

		public function get views():Vector.<View> {
			return this._views;
		}
		
		public function get files():Vector.<File> {
			return this._files;
		}
		
		nsarmored function set parent(value:View):void {
			this._parent = value;
		}
		
		public function get parent():View {
			return this._parent;
		}
		
		public function get className():String {
			return this._class;
		}
		
		public function get branch():String {
			return this._branch;
		}
		
		public function get level():uint {
			return this._level;
		}
		
		public function get mistake():String {
			return this._mistake;
		}
		
		public function get standard():String {
			return this._standard;
		}
		
		public function get layer():String {
			return this._layer;
		}

		public function get history():Boolean {
			return this._history;	
		}
		
		public function get track():String {
			return this._track;
		}
		
		public function get title():String {
			return this._title;
		}
		
		public function get uniqueId():String {
			return this.id + '_' + this.level;
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function get node():XML {
			return this._node;
		}
		
		public function dispose():void {
			if (this.hasViews) {
				var id:uint = this._views.length;
				while (id--) {
					this._views[id].dispose();
					this._views.splice(id, 1);
				}
				this._views = null;
			}
			if (this.hasFiles) {
				id = this._files.length;
				while (id--) {
					this._files[id].dispose();
					this._files.splice(id, 1);
				}
				this._files = null;
			}
			BRANCH = new String();
			LIST = null;
			INDEX = 0;
			this._binding = null;
			this._standard = null;
			this._mistake = null;
			this._parent = null;
			this._branch = null;
			this._layer = null;
			this._class = null;
			this._track = null;
			this._title = null;
			this._node = null;
			this._id = null;
		}
		
		public function toString():String {
			return '[View ' + this.id + ']';
		}
	}
}