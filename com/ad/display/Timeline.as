package com.ad.display {
	import com.ad.common.getLayer;
	import com.ad.external.GetLayers;
	import com.ad.display.Leprechaun;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public class Timeline extends Leprechaun {
		protected var APIKey:String;
		
		public function Timeline(key:String) {
			this.APIKey = key;
		}
		
		public function getLayer(id:String):Layer {
			return com.ad.common.getLayer(id, this.APIKey);
		}
		
		public function cleanupLayers():void {
			GetLayers.fromFileID(this.APIKey).cleanupAllLayers();
		}
		
		override public function toString():String {
			return '[Timeline ' + super.name + ']';
		}
	}
}