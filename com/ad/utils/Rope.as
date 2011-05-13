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
		
		public static function binding(raw:String, substitutions:Object):String {
			if (!substitutions) return raw;
			var subRegex:RegExp = /(?P<var_name>\{\s*[^\}]*\})/g;
			var result:Object = subRegex.exec(raw);
			var var_name:String = result ? result.var_name : null;
			var matches:Array = [];
			var numRuns:int = 0;
			while (Boolean(result) && Boolean(result.var_name)) {
				if (result.var_name) {
					var_name = result.var_name;
					var_name = var_name.replace('{', '');
					var_name = var_name.replace('}', '');
					var_name = var_name.replace( /\s*/g, '');
				}
				matches.push({ start: result.index, end: result.index + result.var_name.length, changeTo: substitutions[var_name] });
				numRuns++;
				if (numRuns > 400) break;
				result = subRegex.exec(raw);
				var_name = result ? result.var_name : null;
			}
			if (matches.length == 0) return raw;
			var buffer:Array = [];
			var lastMatch:Object, match:Object;
			var previous:String = raw.substr(0, matches[0].start);
			var subs:String;
			for each (match in matches) {
				if (lastMatch) {
					previous = raw.substring(lastMatch.end, match.start);
				}
				buffer.push(previous);
				buffer.push(match.changeTo);
				lastMatch = match;
			}
			buffer.push(raw.substring(match.end));
			return buffer.join('');
		}
		
		public static function getBindingSubstitutions(raw:String):Array {
			var subRegex:RegExp = /(?P<var_name>\{\s*[^\}]*\})/g;
			var result:Object = subRegex.exec(raw);
			var var_name:String = result ? result.var_name : null;
			var matches:Array = [];
			var numRuns:int = 0;
			while (Boolean(result) && Boolean(result.var_name)) {
				if (result.var_name) {
					var_name = result.var_name;
					var_name = var_name.replace('{', '');
					var_name = var_name.replace('}', '');
					var_name = var_name.replace( /\s*/g, '');
				}
				result[0] = result[0].replace('{', '');
				result[0] = result[0].replace('}', '');
				result[0] = result[0].replace( /\s*/g, '');
				matches[numRuns] = result[0];
				numRuns++;
				if (numRuns > 400) break;
				result = subRegex.exec(raw);
			}
			return matches;
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