package com.ad.data {

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 * TODO: 
	 */
	public class MetaData extends ValueObject {
		public var _aacaot:int;
		public var _avclevel:Number;
		public var _avcprofile:Number;
		public var _audiocodecid:*;
		public var _audiodatarate:Number;
		public var _audiodelay:Number;
		public var _audiosize:Number;
		public var _canSeekToEnd:Boolean;
		public var _creationdate:String;
		public var _cuePoints:Array;
		public var _datasize:Number;
		public var _duration:Number;
		public var _filesize:Number;
		public var _framerate:Number;
		public var _height:Number;
		public var _keyframes:Object;
		public var _lastkeyframetimestamp:Number;
		public var _lasttimestamp:Number;
		public var _metadatacreator:String = '';
		public var _metadatadate:Date;
		public var _seekpoints:Array;
		public var _tags:Array;
		public var _trackinfo:*;
		public var _videocodecid:*;
		public var _videodatarate:Number;
		public var _videoframerate:Number;
		public var _videosize:Number;
		public var _width:Number;
		public var _xtradata:String;
		public var _moovposition:Number;
		
		public function MetaData(vars:Object = null)
		{
			super(vars);
		}
		
		public function get aacaot():int{return this._aacaot;}
		public function set aacaot(value:int):void{this._aacaot = value;}
		
		public function get avclevel():Number{return this._avclevel;}
		public function set avclevel(value:Number):void{this._avclevel = value;}
		
		public function get avcprofile():Number{return this._avcprofile;}
		public function set avcprofile(value:Number):void{this._avcprofile = value;}
		
		public function get audiocodecid():*{return this._audiocodecid;}
		public function set audiocodecid(value:*):void{this._audiocodecid = value;}
		
		public function get audiodatarate():Number{return this._audiodatarate;}
		public function set audiodatarate(value:Number):void{this._audiodatarate = value;}
		
		public function get audiodelay():Number{return this._audiodelay;}
		public function set audiodelay(value:Number):void{this._audiodelay = value;}
		
		public function get audiosize():Number{return this._audiosize;}
		public function set audiosize(value:Number):void{this._audiosize = value;}
		
		public function get canSeekToEnd():Boolean{return this._canSeekToEnd;}
		public function set canSeekToEnd(value:Boolean):void{this._canSeekToEnd = value;}
		
		public function get creationdate():String{return this._creationdate;}
		public function set creationdate(value:String):void{this._creationdate = value;}
		
		public function get cuePoints():Array{return this._cuePoints;}
		public function set cuePoints(value:Array):void{this._cuePoints = value;}
		
		public function get datasize():Number{return this._datasize;}
		public function set datasize(value:Number):void{this._datasize = value;}
		
		public function get duration():Number{return this._duration;}
		public function set duration(value:Number):void{this._duration = Math.floor(value);}
		
		public function get filesize():Number{return this._filesize;}
		public function set filesize(value:Number):void{this._filesize = value;}
		
		public function get framerate():Number{return this._framerate;}
		public function set framerate(value:Number):void{this._framerate = value;}
		
		public function get height():Number{return this._height;}
		public function set height(value:Number):void{this._height = value;}
		
		public function get keyframes():Object{return this._keyframes;}
		public function set keyframes(value:Object):void{this._keyframes = value;}
		
		public function get lastkeyframetimestamp():Number{return this._lastkeyframetimestamp;}
		public function set lastkeyframetimestamp(value:Number):void{this._lastkeyframetimestamp = value;}
		
		public function get lasttimestamp():Number{return this._lasttimestamp;}
		public function set lasttimestamp(value:Number):void{this._lasttimestamp = value;}
		
		public function get metadatacreator():String{return this._metadatacreator;}
		public function set metadatacreator(value:String):void{this._metadatacreator = value;}
		
		public function get metadatadate():Date{return this._metadatadate;}
		public function set metadatadate(value:Date):void{this._metadatadate = value;}
		
		public function get seekpoints():Array{return this._seekpoints;}
		public function set seekpoints(value:Array):void{this._seekpoints = value;}
		
		public function get tags():Array{return this._tags;}
		public function set tags(value:Array):void{this._tags = value;}
		
		public function get trackinfo():*{return this._trackinfo;}
		public function set trackinfo(value:*):void{this._trackinfo = value;}
		
		public function get videocodecid():*{return this._videocodecid;}
		public function set videocodecid(value:*):void{this._videocodecid = value;}
		
		public function get videodatarate():Number{return this._videodatarate;}
		public function set videodatarate(value:Number):void{this._videodatarate = value;}
		
		public function get videoframerate():Number{return this._videoframerate;}
		public function set videoframerate(value:Number):void{this._videoframerate = value;}
		
		public function get videosize():Number{return this._videosize;}
		public function set videosize(value:Number):void{this._videosize = value;}
		
		public function get width():Number{return this._width;}
		public function set width(value:Number):void{this._width = value;}
		
		public function get xtradata():String{return this._xtradata;}
		public function set xtradata(value:String):void{this._xtradata = value;}
		
		public function get moovposition():Number{return this._moovposition;}
		public function set moovposition(value:Number):void{this._moovposition = value;}
	}
}

/*
internal class SeekPoints {
	private var _time:Number = 0;
	private var _offset:Number = 304121;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 
	// > TIME
	// 
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public function set time(value:Number):void
	{
		this._time = value;
	}
	
	public function get time():Number
	{
		return this._time;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 
	// > OFFSET
	// 
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public function set offset(value:Number):void
	{
		this._offset = value;
	}
	
	public function get offset():Number
	{
		return this._offset;
	}
}

internal class TrackInfo {
	private var _timescale:Number;
	private var _sampledescription:SampleDescription;
	private var _length:Number;
	private var _language:String;
	
	public function set timescale(value:Number):void
	{
		this._timescale = value;
	}
	
	public function get timescale():Number
	{
		return this._timescale;
	}
	
	public function set sampledescription(value:SampleDescription):void
	{
		this._sampledescription = value;
	}
	
	public function get sampledescription():SampleDescription
	{
		return this._sampledescription;
	}
	
	public function set length(value:Number):void
	{
		this._length = value;
	}
	
	public function get length():Number
	{
		return this._length;
	}
	
	public function set language(value:String):void
	{
		this._language = value;
	}
	
	public function get language():String
	{
		return this._language;
	}
}

internal class SampleDescription {
	private var _sampletype:String;
	
	public function set sampletype(value:String):void
	{
		this._sampletype = value;
	}
	
	public function get sampletype():String
	{
		return this._sampletype;
	}
}*/