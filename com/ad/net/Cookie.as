/**
 * ******************************************************************************************************************************
 * Localizações dos 'flashCookies':
 * ******************************************************************************************************************************
 * Windows XP:
 *  - %APPDATA%\Macromedia\Flash Player\#SharedObjects\
 *  - %APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys
 *  - C:\Documents and Settings\LocalService\Application Data\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\
 *  - C:\Documents and Settings\LocalService\Application Data\Macromedia\Flash Player\#SharedObjects\
 *  - C:\Documents and Settings\NetworkService\Application Data\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\
 *  - C:\Documents and Settings\NetworkService\Application Data\Macromedia\Flash Player\#SharedObjects\\
 *  - C:\Documents and Settings\\Application Data\Macromedia\Flash Player\#SharedObjects\\
 *  - C:\Documents and Settings\\Application Data\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\
 *  - C:\WINDOWS\system32\Macromed\
 *  - Para AIR Applications: %APPDATA%\\Local Store\#SharedObjects\
 *	
 * Windows Vista e mais recentes:
 *  - %APPDATA%\Macromedia\Flash Player\#SharedObjects\
 *  - %APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys
 *	
 * Mac OS X:
 *  - ~/Library/Preferences/Macromedia/Flash Player/#SharedObjects/
 *  - ~/Library/Preferences/Macromedia/Flash Player/macromedia.com/support/flashplayer/sys/
 *  - Para AIR Applications: ~/Library/Preferences/{AIR Application Name}/Local Store/#SharedObjects/
 *	
 * Linux/Unix:
 *  - ~/.macromedia/Flash_Player/#SharedObjects/
 */
package com.ad.net {
	import com.ad.events.EventControl;
	
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	/**
	 * Dispatched when a remote shared object has been updated by the server.
	 * @eventType flash.events.SyncEvent.SYNC
	 */
	[Event(name = 'sync', type = 'flash.events.SyncEvent')]
	
	/**
	 * Dispatched when a SharedObject instance is reporting its status or error condition.
	 * @eventType flash.events.NetStatusEvent.NET_STATUS
	 */
	[Event(name = 'netStatus', type = 'flash.events.NetStatusEvent')]
	
	/**
	 * Dispatched when an exception is thrown asynchronously &#x2014; that is, from native asynchronous code.
	 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
	 */
	[Event(name='asyncError', type='flash.events.AsyncErrorEvent')]
	
	public final class Cookie extends EventControl {
		private static var _self:Cookie = new Cookie();
		
		private var _sol:SharedObject;
		private var _localPath:String;
		private var _secure:Boolean;
		private var _name:String;
		private var _data:Object;
		
		public function Cookie() {
			if (_self) throw new Error('Instantiation failed: Use Cookie.cookie instead of new.');
		}
		
		public static function get sol():Cookie {
			return _self;
		}
		
		public function getLocal(name:String, localPath:String = '/', secure:Boolean = false):void {
			this._sol = SharedObject.getLocal(name, localPath, secure);
			this._localPath = localPath;
			this._secure = secure;
			this._name = name;
		}
		
		public function flush(minDiskSpace:int = 0):String {
			var flushStatus:String;
			var output:String = '';
			try {
				flushStatus = this._sol.flush(minDiskSpace);
			} catch (event:Error) {
				output += 'Error. Could not write SharedObject to disk\n';
			} finally {
				if (flushStatus) {
					switch (flushStatus) {
						case SharedObjectFlushStatus.PENDING:
							this._sol.addEventListener(NetStatusEvent.NET_STATUS, this.onFlushStatus);
							output += 'Requesting permission to save object...\n';
							break;
						case SharedObjectFlushStatus.FLUSHED:
							output += 'Value flushed to disk.\n';
							break;
					}
				}
			}
			return output;
		}
		
		public function clear():Boolean {
			try {
				this._sol = SharedObject.getLocal(this._name, this._localPath, this._secure);
				for (var property:Object in this._sol.data) {
					delete this._sol.data[property];
				}
				this._sol.clear();
				return true;
			} catch (event:Error) {
				trace(event.message);
			}
			return false;
		}
		
		public function get data():Object {
			return SharedObject.getLocal(this._name, this._localPath, this._secure).data;;
		}
		
		private function onFlushStatus(event:NetStatusEvent):void {
			super.dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS));
		}
	}
}