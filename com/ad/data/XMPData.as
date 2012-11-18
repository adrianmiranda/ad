package com.ad.data {
	import flash.display.Sprite;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: 
	 */
	public class XMPData extends ValueObject {
		private var _liveXML:String;
		private var _data:String;
		
		public function XMPData(vars:Object = null) {
			super(vars);
		}
		
		private function parse():void {
			// N/A yet.
		}
		
		public function get data():String {
			return this._data;
		}

		public function set data(value:String):void {
			this._data = value;
		}
		
		public function get liveXML():String {
			return this._liveXML;
		}

		public function set liveXML(value:String):void {
			this._liveXML = value;
		}
		
		/*
		//trace('raw XMP =\n');
		//trace(info.data);
		var cuePoints:Array = new Array();
		var cuePoint:Object;
		var strFrameRate:String;
		var nTracksFrameRate:Number;
		var strTracks:String = '';
		var onXMPXML:XML = new XML(info.data);
		// Set up namespaces to make referencing easier
		var xmpDM:Namespace = new Namespace('http://ns.adobe.com/xmp/1.0/DynamicMedia/');
		var rdf:Namespace = new Namespace('http://www.w3.org/1999/02/22-rdf-syntax-ns#');
		for each (var it:XML in onXMPXML..xmpDM::Tracks) {
			var strTrackName:String = it.rdf::Bag.rdf::li.rdf::Description.@xmpDM::trackName;
			var strFrameRateXML:String = it.rdf::Bag.rdf::li.rdf::Description.@xmpDM::frameRate;
			strFrameRate = strFrameRateXML.substr(1,strFrameRateXML.length);
			nTracksFrameRate = Number(strFrameRate);
			strTracks += it;
		}
		var onXMPTracksXML:XML = new XML(strTracks);
		var strCuepoints:String = '';
		for each (var item:XML in onXMPTracksXML..xmpDM::markers) {
			strCuepoints += item;
		}
		//trace(strCuepoints);
		*/
	}
}