package {
	import com.ad.proxy.nsmedia
	import com.ad.interfaces.IMedia;
	import com.ad.data.EqualizeParse;
	
	import __AS3__.vec.Vector;
	
	public final class MediaControl {
		private static var mediaCollection:Vector.<IMedia> = new Vector.<IMedia>();
		
		public static function playAllMedias(type:Class = null):void {
			var id:int;
			if (type) {
				while (id < mediaCollection.length) {
					if (mediaCollection[id] is type) {
						mediaCollection[id].play();
					}
					id++;
				}
			} else {
				while (id < mediaCollection.length) {
					mediaCollection[id].play();
					id++;
				}
			}
		}
		
		public static function pauseAllMedias(type:Class = null):void {
			var id:int;
			if (type) {
				while (id < mediaCollection.length) {
					if (mediaCollection[id] is type) {
						mediaCollection[id].pause();
					}
					id++;
				}
			} else {
				while (id < mediaCollection.length) {
					mediaCollection[id].pause();
					id++;
				}
			}
		}
		
		public static function stopAllMedias(type:Class = null):void {
			var id:int;
			if (type) {
				while (id < mediaCollection.length) {
					if (mediaCollection[id] is type) {
						mediaCollection[id].stop();
					}
					id++;
				}
			} else {
				while (id < mediaCollection.length) {
					mediaCollection[id].stop();
					id++;
				}
			}
		}
		
		public static function addMedia(media:IMedia):void {
			if (mediaCollection.indexOf(media) == -1) return;
			mediaCollection.push(value);
		}
		
		public static function removeMedia(media:*):void {
			var index:int = mediaCollection.indexOf(media);
			if (index > -1) {
				mediaCollection[index].stop();
				mediaCollection.splice(index, 1);
			}
		}
		
		/** @private */
		nsmedia static function equalize(equalizeParse:EqualizeParse):void {
			var id:int;
			do {
				use namespace nsmedia;
				Object(mediaCollection[id]).update(equalizeParse);
				id++;
			} while (id < mediaCollection.length)
		}
	}
}