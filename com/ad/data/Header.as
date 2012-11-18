package com.ad.data {
	import com.ad.common.num;
	import com.ad.common.bool;
	import com.ad.errors.ADError;
	
	import __AS3__.vec.Vector;
	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class Header {
		private var _binding:DisplayObject;
		private var _files:Vector.<File>;
		private var _languages:Language;
		private var _connections:uint;
		private var _history:Boolean;
		private var _strict:Boolean;
		private var _track:String;
		private var _flow:String;
		private var _title:String;
		private var _views:View;
		private var _xml:XML;
		
		public function Header(xml:XML, binding:DisplayObject = null) {
			this.validateHeader(xml);
			this._xml = xml;
			this._binding = binding;
			this._title = xml.@title.toString();
			this._track = xml.@track.toString();
			this._strict = xml.@strict != undefined ? bool(xml.@strict.toString()) : true;
			this._flow = xml.@flow.toString() || 'normal';
			this._languages = new Language(this.parseLanguages(xml), this._binding);
			this._views = new View(this.parseTreeBase(xml), binding);
			this._files = this.parseFiles(xml);
			this._history = xml.@history != undefined ? bool(xml.@history.toString()) : true;
			this._connections = num(xml.@connections.toString()) || 2;
		}
		
		private function validateHeader(node:XML):void {
			var error:String = '*Invalid Views XML* Header ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (!node.hasOwnProperty('base')) {
				throw new ADError(error + 'node base missing required');
			}
			else if (node.base.length() > 1) {
				throw new ADError(error + 'xml contains more than one base');
			}
		}
		
		private function parseTreeBase(xml:XML):XML {
			return XML(xml.base[0]);
		}
		
		private function parseLanguages(xml:XML):XML {
			if (xml.languages == undefined) {
				return new XML('<languages/>');
			}
			return XML(xml.languages);
		}
		
		private function parseFiles(list:XML):Vector.<File> {
			var fileList:Vector.<File> = new Vector.<File>();
			for each (var child:XML in list.file) {
				var file:File = new File(child, this._binding);
				fileList.push(file);
			}
			return fileList;
		}
		
		public function getView(value:* = ''):View {
			return this._views.getView(value);
		}
		
		public function getLanguage(value:* = ''):Language {
			return this._languages.getLanguage(value);
		}
		
		public function getFile(value:* = 0):File {
			if (this.hasFiles) {
				if (this.files.hasOwnProperty(value)) return this.files[value];
				for (var id:int; id < this.files.length; id++) {
					var file:File = this.files[id];
					if (value == file.id) {
						return file;
					}
				}
			}
			return null;
		}
		
		public function get hasLanguages():Boolean {
			return this._languages.hasLanguages;
		}
		
		public function get hasViews():Boolean {
			return this._views.hasViews;
		}
		
		public function get hasFiles():Boolean {
			if (!this._files) return false;
			return this._files.length > 0;
		}
		
		public function get binding():DisplayObject {
			return this._binding;
		}
		
		public function get languages():Language {
			return this._languages;
		}
		
		public function get views():View {
			return this._views;
		}
		
		public function get files():Vector.<File> {
			return this._files;
		}
		
		public function get connections():uint {
			return this._connections;
		}
		
		public function get history():Boolean {
			return this._history;
		}
		
		public function get title():String {
			return this._title;
		}
		
		public function get strict():Boolean {
			return this._strict;
		}
		
		public function get track():String {
			return this._track;
		}
		
		public function get flow():String {
			return this._flow;
		}
		
		public function get xml():XML {
			return this._xml;
		}
		
		public function dispose():void {
			var id:uint = this._files.length;
			while (id--) {
				this._files[id].dispose();
				this._files.splice(id, 1);
			}
			this._views.dispose();
			this._languages.dispose();
			this._languages = null;
			this._binding = null;
			this._views = null;
			this._files = null;
			this._title = null;
			this._xml = null;
		}
		
		public function toString():String {
			return '[Header ' + this._title + ']';
		}
	}
}