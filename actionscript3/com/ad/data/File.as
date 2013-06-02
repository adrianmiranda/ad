package com.ad.data {
	import com.ad.utils.Binding;
	import com.ad.common.num;
	import com.ad.common.bool;
	import com.ad.errors.ADError;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com> 
	 */
	public final class File {
		private var _binding:DisplayObject;
		private var _parent:View;
		private var _backgroundConnections:uint;// no yet implemented
		private var _runInBackground:Boolean;
		private var _preload:Boolean;
		private var _noCache:Boolean;
		private var _bytes:uint;
		private var _type:String;
		private var _url:String;
		private var _id:String;
		private var _xml:XML;
		
		public function File(xml:XML, binding:DisplayObject = null) {
			this.validateFileNode(xml);
			this._xml = xml;
			this._binding = binding;
			this._id = xml.@id.toString();
			this._url = this.bind(xml.@url.toString());
			this._type = xml.@type.toString() || this._url.substring(this._url.lastIndexOf('.') + 1, this._url.length);
			this._bytes = ((num(xml.@kb) || 20000 / 1024) * 1024);
			this._preload = xml.@preload != undefined ? bool(xml.@preload) : true;
			this._noCache = xml.@noCache != undefined ? bool(xml.@noCache) : true;
			if (xml.attribute('run-in-background') != undefined) {
				this._preload = false;
				this._runInBackground = bool(xml.attribute('run-in-background'));
				trace("Warning: '"+ this._id +"' file is running in the background.");
			}
		}
		
		private function validateFileNode(node:XML):void {
			var error:String = '*Invalid Views XML* File ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (node.@id == undefined) {
				throw new ADError(error + 'node missing required attribute \'id\'');
			}
			else if (!/^([a-zA-Z0-9-_])+$/g.test(node.@id)) {
				throw new ADError(error + node.@id + ' \'id\' attribute contains invalid characters');
			}
			else if (node.@url == undefined) {
				throw new ADError(error + 'node missing required attribute \'url\'');
			}
			else if (!Binding.isValid(node.@url)) {
				throw new ADError(error + node.@id + ' \'url\' attribute contains invalid binding expression \'' + node.@url + '\'');
			}
			else {
				for each (var id:String in node.parent().file.@id) {
					if (node.parent().file.(@id == id).length() > 1) {
						throw new ADError(error + id + ' node duplicate');
					}
				}
			}
		}
		
		private function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}
		
		public function get binding():DisplayObject {
			return this._binding;
		}
		
		public function set parent(value:View):void {
			this._parent = value;
		}
		
		public function get parent():View {
			return this._parent;
		}
		
		public function get preload():Boolean {
			return this._preload;
		}
		
		public function get noCache():Boolean {
			return this._noCache;
		}

		public function get runInBackground():Boolean {
			return this._runInBackground;
		}
		
		public function get bytes():uint {
			return this._bytes;
		}
		
		public function get type():String {
			return this._type;
		}
		
		public function get url():String {
			return this._url;
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function get xml():XML {
			return this._xml;
		}
		
		public function dispose(flush:Boolean = false):void {
			this._binding = null;
			this._parent = null;
			this._xml = null;
			this._id = null;
		}
		
		public function toString():String {
			return '[File ' + this._id + ']';
		}
	}
}