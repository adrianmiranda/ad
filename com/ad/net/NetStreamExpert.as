package com.ad.net {
	import com.ad.common.num;
	import com.ad.common.clamp;
	import com.ad.common.normalize;
	import com.ad.common.percentage;
	
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * @tip To use video steps just player 10.1 or older and
	 * Export video with key frame distance: 1
	 */
	public class NetStreamExpert extends NetStream {
		public static var checkPolicyFile:Boolean = true;
		private var _connection:NetConnection;
		private var _isPaused:Boolean;
		private var _timer:Timer;
		
		public function NetStreamExpert(connection:NetConnection = null, timer:Timer = null, peerID:String = 'connectToFMS') {
			super(this.getOwnConnection(connection), peerID);
			super.checkPolicyFile = NetStreamExpert.checkPolicyFile;
			this._timer = timer;
		}
		
		protected function getOwnConnection(connection:NetConnection):NetConnection {
			if (connection) return connection;
			this._connection = new NetConnection();
			this._connection.connect(null);
			return this._connection;
		}
		
		override public function publish(name:String = null, type:String = null):void {
			this._isPaused = false;
			super.checkPolicyFile = NetStreamExpert.checkPolicyFile;
			if (this._timer && !this._timer.running) {
				this._timer.start();
			}
			super.publish(name, type);
		}
		
		override public function play(...rest):void {
			this._isPaused = false;
			super.checkPolicyFile = NetStreamExpert.checkPolicyFile;
			if (this._timer && !this._timer.running) {
				this._timer.start();
			}
			super.play.apply(this, rest);
		}
		
		override public function pause():void {
			if (!this._isPaused) {
				this._isPaused = true;
				if (this._timer && this._timer.running) {
					this._timer.stop();
				}
				super.pause();
			}
		}
		
		override public function resume():void {
			if (this._isPaused) {
				this._isPaused = false;
				super.checkPolicyFile = NetStreamExpert.checkPolicyFile;
				super.resume();
				if (this._timer && !this._timer.running) {
					this._timer.start();
				}
			}
		}
		
		override public function togglePause():void {
			this._isPaused ? this.resume() : this.pause();
		}
		
		override public function close():void {
			this.stop();
			if (!this.loaded) {
				super.close();
			}
		}
		
		override public function seek(second:Number):void {
			super.seek(num(second));
		}
		
		public function stop():void {
			if (this._timer && this._timer.running) {
				this._timer.stop();
			}
			this.pause();
			this.seek(0);
		}
		
		public function get connection():NetConnection {
			return this._connection;
		}
		
		override public function get bufferTime():Number {
		    return num(super.bufferTime);
		}
		
		override public function get bufferLength():Number {
		    return num(super.bufferLength);
		}
		
		override public function get time():Number {
			return num(super.time);
		}
		
		override public function get bytesLoaded():uint {
			return uint(num(super.bytesLoaded));
		}
		
		override public function get bytesTotal():uint {
			return uint(num(super.bytesTotal));
		}
		
		public function get bufferPercent():Number {
		    return clamp(percentage(this.bufferTime, this.bufferLength), 0, 100);
		}
		
		public function get bytesPercent():Number {
		    return clamp(percentage(this.bytesLoaded, this.bytesTotal), 0, 100);
		}
		
		public function get buffer():Number {
		    return num(clamp(normalize(this.bufferTime, 0, this.bufferLength), 0, 1));
		}
		
		public function get bytes():Number {
			return num(clamp(normalize(this.bytesLoaded, 0, this.bytesTotal), 0, 1));
		}
		
		public function get buffered():Boolean {
			return this.buffer == 1;
		}
		
		public function get loaded():Boolean {
			return this.bytes == 1;
		}
		
		public function get paused():Boolean {
			return this._isPaused;
		}
		
		override public function dispose():void {
			if (this._timer) {
				if (this._timer.running) {
					this._timer.stop();
				}
				this._timer = null;
			}
			this.close();
			this._isPaused = true;
			super.dispose();
		}
		
		override public function toString():String {
			return '[NetStreamExpert]';
		}
	}
}