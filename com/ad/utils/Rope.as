package com.ad.utils {
	
	public final class Rope {
		
		public static function removeAccents(value:String):String {
			var collection:Array = [
				{ pattern:/[äáàâãª]/g, char:'a' }, { pattern:/[ÄÁÀÂÃ]/g, char:'A' },
				{ pattern:/[ëéèê]/g, char:'e' }, { pattern:/[ËÉÈÊ]/g, char:'E' },
				{ pattern:/[íîïì]/g, char:'i' }, { pattern:/[ÍÎÏÌ]/g, char:'I' },
				{ pattern:/[öóòôõº]/g, char:'o' }, { pattern:/[ÖÓÒÔÕ]/g, char:'O' },
				{ pattern:/[üúùû]/g, char:'u' }, { pattern:/[ÜÚÙÛ]/g, char:'U' },
				{ pattern:/[ç]/g, char:'c' }, { pattern:/[Ç]/g, char:'C' },
				{ pattern:/[ñ]/g, char:'n' }, { pattern:/[Ñ]/g, char:'N' }
			];
			var id:int;
			var total:int = collection.length;
			for (id; id < total; id++) {
				value = value.replace(collection[id].pattern, collection[id].char);
			}
			collection = null;
			return value;
		}
		
		public static function removeAccentsAndSpaces(value:String):String {
			var collection:Array = [
				{ pattern:/[äáàâãª]/g, char:'a' }, { pattern:/[ÄÁÀÂÃ]/g, char:'A' },
				{ pattern:/[ëéèê]/g, char:'e' }, { pattern:/[ËÉÈÊ]/g, char:'E' },
				{ pattern:/[íîïì]/g, char:'i' }, { pattern:/[ÍÎÏÌ]/g, char:'I' },
				{ pattern:/[öóòôõº]/g, char:'o' }, { pattern:/[ÖÓÒÔÕ]/g, char:'O' },
				{ pattern:/[üúùû]/g, char:'u' }, { pattern:/[ÜÚÙÛ]/g, char:'U' },
				{ pattern:/[ç]/g, char:'c' }, { pattern:/[Ç]/g, char:'C' },
				{ pattern:/[ñ]/g, char:'n' }, { pattern:/[Ñ]/g, char:'N' },
				{ pattern:/[ ]/g, char:'' }, { pattern:/[.]/g, char:'' }
			];
			var id:int;
			var total:int = collection.length;
			for (id; id < total; id++) {
				value = value.replace(collection[id].pattern, collection[id].char);
			}
			collection = null;
			return value;
		}
		
		// TODO: Implementar todos os caractéres especiais
		public static function removeSpecialChars(value:String):String {
			return value.replace(/[?!@#$%[\]{.}(|)-:;,<~>÷&ˆ^*+=`]/g, '');
		}
		
		public static function trim(value:String):String {
			return leftTrim(rightTrim(value));
		}
		
		public static function leftTrim(value:String):String {
			var totalChars:Number = value.length;
			var id:int = -1;
			while (++id < totalChars) {
				if (value.charCodeAt(id) > 32) {
					return value.substring(id);
				}
			}
			return '';
		}
		
		public static function rightTrim(value:String):String {
			var id:int = value.length;
			while (id--) {
				if (value.charCodeAt(id) > 32) {
					return value.substring(0, id + 1);
				}
			}
			return '';
		}
	}
}