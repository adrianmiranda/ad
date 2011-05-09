package com.ad.utils {
	import com.ad.events.EventControl;
	import com.ad.data.URI;
	
	public final class URIComposite extends URIProxy {
		private var _uriCollection:Vector.<URI> = new Vector.<URI>();
		private var _uriDefault:URI;
		private var _uriError:URI;
		
		public function URIComposite() {
			// no yet implement
		}
		
		public function attachURI(value:URI):void {
			if (this._uriCollection.indexOf(value) != -1) {
				trace(this.toString(), value.name, 'uri already exists.');
				return;
			}
			this._uriCollection.push(value);
		}
		
		public function detachURI(value:URI):void {  
			var index:int = this._uriCollection.indexOf(value);
			if (index == -1) {
				trace(this.toString(), value.name, 'uri does not exist.');
				return;
			}
			this._uriCollection.splice(index, 1);
		}
		
		public function getURIByIndex(index:uint):URI {
			if (index >= this._uriCollection.length) {
				trace(this.toString(), index, 'isn\'t a valid index.');
				return null;
			}
			return this._uriCollection[index];
		}
		
		public function getURIByValue(value:String):URI {
			var id:int = this._uriCollection.length;
			while (id--) {
				if (this._uriCollection[id].id == value) {
					return this._uriCollection[id];
				}
				if (this._uriCollection[id].uri == value) {
					return this._uriCollection[id];
				}
				if (this._uriCollection[id].source == value) {
					return this._uriCollection[id];
				}
			}
			return null;
		}
		
		public function getURI(value:Object):URI {
			if (value is uint) {
				return this.getURIByIndex(uint(value));
			} else if (value is String) {
				return this.getURIByValue(String(value));
			}
			return null;
		}
		
		public function attachURIDefault(value:URI):void {
			if (!this._uriDefault) {
				// no yet implement
			}
		}
		
		public function detachURIError(value:URI):void {
			if (!this._uriError) {
				// no yet implement
			}
		}
		
		public function clear():void {
			this._uriDefault = null;
			this._uriError = null;
			var id:int = this._uriCollection.length;
			while (id--) {
				this._uriCollection.splice(id, 1);
			}
		}
		
		override public function toString():String {
			return '[URIComposite]';
		}
	}
}