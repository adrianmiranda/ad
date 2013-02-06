package com.ad.data {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://help.adobe.com/en_US/as3/dev/WSD30FA424-950E-43ba-96C8-99B926943FE7.html
	 * TODO: 
	 */
	public class CuePoint extends ValueObject {
		private var _parameters:Array;
		private var _name:String;
		private var _time:String;
		private var _type:String;
		
		public function CuePoint(vars:Object = null) {
			super(vars);
		}
		
		public function get parameters():Array {
			return this._parameters;
		}
		public function set parameters(value:Array):void {
			this._parameters = value;
		}
		
		public function get name():String {
			return this._name;
		}
		public function set name(value:String):void {
			this._name = value;
		}
		
		public function get time():String {
			return this._time;
		}
		public function set time(value:String):void {
			this._time = value;
		}
		
		public function get type():String {
			return this._type;
		}
		public function set type(value:String):void {
			this._type = value;
		}
	}
}