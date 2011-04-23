package com.ad.utils {
	
	public final class Validation {
		
		public static function isEmail(email:String):Boolean {
			var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExpression.test(email);
		}
		
		public static function isEmpty(value:String, trim:Boolean = true):Boolean {
			if (value == null) return true;
			if (trim) value = value.replace(/\s/gi, '');
			return value == '';
		}
		
		public static function isCPF(value:String, required:Boolean=true):Boolean {
			if (required && isEmpty(value)) return false;
			var result:Boolean = true;
			var total:int = value.length;
			if (total < 11) {
				value = String('00000000000' + value).substr(total, 11);
				total = 11;
			}
			var digitOne:int = parseInt(value.substring(9, 10), 10);
			var digitTwo:int = parseInt(value.substring(10, 11), 10);
			var sum:int = 0;
			var multiply:int = 10;
			var digitCalc:Number;
			var product:int;
			var id:int;
			for (id = 0; id < 9; id++) {
				product = parseInt(value.substring(id, id + 1) , 10) * multiply;
				sum += product;
				multiply--;
			}
			digitCalc = (sum % 11);
			if (digitCalc == 0 || digitCalc == 1) digitCalc = 0;
			else digitCalc = 11 - digitCalc;
			if (digitCalc != digitOne) result = false;
			sum = 0;
			multiply = 11;
			for (id = 0; id < 10; id++) {
				product = parseInt(value.substring(id, id + 1) , 10) * multiply;
				sum += product;
				multiply--;
			}
			digitCalc = (sum % 11);
			if (digitCalc == 0 || digitCalc == 1) digitCalc = 0;
			else digitCalc = 11 - digitCalc;
			if (digitCalc != digitTwo) result = false;
			return result;
		}
		
		public static function minLength(value:String, length:int, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			return value.length >= length;
		}
		
		public static function isPhone(value:String, localCod:Boolean = false, required:Boolean = true):int {
			if(required && isEmpty(value)) return -1;
			var id:uint = 0;
			if (value.match(/[^0-9]/gi).length > 0) id = 1;
			else if (isSequence(value) || isOnlyChar(value)) id = 2;
			else if ((localCod && (value.length != 10 && value.length != 11)) || (!localCod && !(value.length == 8))) id = 3;
			else if (parseInt(value.substr( -8).charAt(0)) == 0) {
				id = 4;
			}
			return id;
		}
		
		public static function isCellPhone(value:String, localCod:Boolean = false, required:Boolean = true):int {
			if (required && isEmpty(value)) return -1;
			var id:uint = 0;
			if (value.match(/[^0-9]/gi).length > 0) id = 1;
			else if (isSequence(value) || isOnlyChar(value)) id = 2;
			else if ((localCod && (value.length != 10 && value.length != 11)) || (!localCod && !(value.length == 8))) id = 3;
			else if (parseInt(value.substr( -8).charAt(0)) < 6) {
				id = 4;
			}
			return id;
		}
		
		public static function isSequence(value:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			var firstChar:Number = value.charCodeAt(0);
			var total:int = value.length;
			var id:int = 1;
			for (id; id < total; id++) {
				firstChar++;
				if (value.charCodeAt(id) != firstChar) {
					firstChar = value.charCodeAt(0);
					for (var uI:int = 1; uI < total; uI++) {
						firstChar--;
						if (value.charCodeAt(uI) != firstChar) {
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public static function isOnlyChar(value:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			var total:int = value.length;
			var id:int;
			for (id; id < total; id++) {
				if ((value.charAt(id - 1) != value.charAt(id)) && id > 0) {
					return true;
				}
			}
			return false;
		}
		
		public static function isDate(date:String):Boolean {
			var dateExpression:RegExp = /(0[1-9]|1[012])[\/](0[1-9]|[12][0-9]|3[01])[\/](19|20)[0-9]{2}/;
			return dateExpression.test(date);
		}
	}
}