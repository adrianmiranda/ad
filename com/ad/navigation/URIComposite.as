package com.ad.utils {
	import com.ad.events.EventControl;
	import com.ad.data.URI;
	
	public final class URIComposite extends EventControl {
		private var _uriCollection:Vector.<URI> = new Vector.<URI>();
		
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
		
		public function clear():void {
			
		}
		
		override public function toString():String {
			return '[URIComposite]';
		}
	}
}