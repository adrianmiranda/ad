package com.ad.net
{
	import flash.utils.Dictionary;
	
	public final class NetStreamStatus
	{
		private static var $map:Dictionary = new Dictionary(true);
		
		public static const WARNING:String = 'warning';
		public static const STATUS:String = 'status';
		public static const ERROR:String = 'error';
		
		public static const CONNECT_SUCCESS:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.Success', STATUS);
		public static const CONNECT_CLOSED:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.Closed', STATUS);
		public static const CALL_BAD_VERSION:NetStreamStatus = new NetStreamStatus('NetConnection.Call.BadVersion', ERROR);
		public static const CALL_FAILED:NetStreamStatus = new NetStreamStatus('NetConnection.Call.Failed', ERROR);
		public static const CALL_PROHIBITED:NetStreamStatus = new NetStreamStatus('NetConnection.Call.Prohibited', ERROR);
		public static const CONNECT_FAILED:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.Failed', ERROR);
		public static const CONNECT_REJECTED:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.Rejected', ERROR);
		public static const CONNECT_APP_SHUTDOWN:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.AppShutdown', ERROR);
		public static const CONNECT_INVALID_APP:NetStreamStatus = new NetStreamStatus('NetConnection.Connect.InvalidApp', ERROR);
		public static const BUFFER_EMPTY:NetStreamStatus = new NetStreamStatus('NetStream.Buffer.Empty', STATUS);
		public static const BUFFER_FULL:NetStreamStatus = new NetStreamStatus('NetStream.Buffer.Full', STATUS);
		public static const BUFFER_FLUSH:NetStreamStatus = new NetStreamStatus('NetStream.Buffer.Flush', STATUS);
		public static const PLAY_START:NetStreamStatus = new NetStreamStatus('NetStream.Play.Start', STATUS);
		public static const PLAY_RESET:NetStreamStatus = new NetStreamStatus('NetStream.Play.Reset', STATUS);
		public static const PLAY_STOP:NetStreamStatus = new NetStreamStatus('NetStream.Play.Stop', STATUS);
		public static const PLAY_PUBLISH_NOTIFY:NetStreamStatus = new NetStreamStatus('NetStream.Play.PublishNotify', STATUS);
		public static const PLAY_UNPUBLISH_NOTIFY:NetStreamStatus = new NetStreamStatus('NetStream.Play.UnpublishNotify', STATUS);
		public static const PLAY_SWITCH:NetStreamStatus = new NetStreamStatus('NetStream.Play.Switch', STATUS);
		public static const PLAY_COMPLETE:NetStreamStatus = new NetStreamStatus('NetStream.Play.Complete', STATUS);
		public static const RECORD_START:NetStreamStatus = new NetStreamStatus('NetStream.Record.Start', STATUS);
		public static const RECORD_STOP:NetStreamStatus = new NetStreamStatus('NetStream.Record.Stop', STATUS);
		public static const PUBLISH_START:NetStreamStatus = new NetStreamStatus('NetStream.Publish.Start', STATUS);
		public static const PUBLISH_IDLE:NetStreamStatus = new NetStreamStatus('NetStream.Publish.Idle', STATUS);
		public static const UNPUBLISH_SUCCESS:NetStreamStatus = new NetStreamStatus('NetStream.Unpublish.Success', STATUS);
		public static const UNPAUSE_NOTIFY:NetStreamStatus = new NetStreamStatus('NetStream.Unpause.Notify', STATUS);
		public static const PAUSE_NOTIFY:NetStreamStatus = new NetStreamStatus('NetStream.Pause.Notify', STATUS);
		public static const SEEK_NOTIFY:NetStreamStatus = new NetStreamStatus('NetStream.Seek.Notify', STATUS);
		public static const PLAY_STREAM_NOT_FOUND:NetStreamStatus = new NetStreamStatus('NetStream.Play.StreamNotFound', ERROR);
		public static const PLAY_FAILED:NetStreamStatus = new NetStreamStatus('NetStream.Play.Failed', ERROR);
		public static const RECORD_NO_ACCESS:NetStreamStatus = new NetStreamStatus('NetStream.Record.NoAccess', ERROR);
		public static const RECORD_FAILED:NetStreamStatus = new NetStreamStatus('NetStream.Record.Failed', ERROR);
		public static const PUBLISH_BAD_NAME:NetStreamStatus = new NetStreamStatus('NetStream.Publish.BadName', ERROR);
		public static const SEEK_FAILED:NetStreamStatus = new NetStreamStatus('NetStream.Seek.Failed', ERROR);
		public static const SEEK_INVALID_TIME:NetStreamStatus = new NetStreamStatus('NetStream.Seek.InvalidTime', ERROR);
		public static const FLUSH_SUCCESS:NetStreamStatus = new NetStreamStatus('SharedObject.Flush.Success', STATUS);
		public static const FLUSH_FAILED:NetStreamStatus = new NetStreamStatus('SharedObject.Flush.Failed', ERROR);
		public static const BAD_PERSISTENCE:NetStreamStatus = new NetStreamStatus('SharedObject.BadPersistence', ERROR);
		public static const URI_MISMATCH:NetStreamStatus = new NetStreamStatus('SharedObject.UriMismatch', ERROR);
		public static const PLAY_INSUFFICIENT_BW:NetStreamStatus = new NetStreamStatus('NetStream.Play.InsufficientBW', WARNING);
		
		public var level:String;
		public var code:String;
		
		public function NetStreamStatus(code:String, level:String)
		{
			this.code = code;
			this.level = level;
			$map[this.code] = this;
		}
		
		public static function get(code:String):NetStreamStatus
		{
			return contains(code) ? $map[code] : null;
		}
		
		public static function contains(code:String):Boolean
		{
			return $map[code] ? true : false;
		}
		
		public function toString():String
		{
			return this.code;
		}
	}
}