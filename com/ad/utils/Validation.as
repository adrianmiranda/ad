package com.ad.utils {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class Validation {
		
		public static function isEmail(value:String):Boolean {
			var emailExpression:RegExp = /^([-\w.])+@\w([-\w.]+)\.([\w]{2,4})$/i;
			//var emailDotExpression:RegExp = /(\.){2,}/gi;
			//value.replace(emailDotExpression, '.');
			return emailExpression.test(value);
		}
		
		public static function isEmpty(value:String, trim:Boolean = true):Boolean {
			if (value == null) return true;
			if (trim) value = value.replace(/\s/gi, '');
			return value == '';
		}
		
		public static function isCPF(value:String, required:Boolean=true):Boolean {
			if (required && isEmpty(value)) return false;
			value = value.split('.').join('').replace('-', '');//@new
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
		
		public static function isDate(value:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			var inputDate:Array = value.split('/');
			if (inputDate.length != 3) return false;
			for (var id:Number = 0; id < inputDate.length; id++) {
				inputDate[id] = parseInt(inputDate[id]);
			}
			inputDate[1] = inputDate[1] - 1;
			var date:Date = new Date(inputDate[2], inputDate[1], inputDate[0]);
			return ((date.getFullYear() == inputDate[2]) && (date.getMonth() == inputDate[1]) && (date.getDate() == inputDate[0]));
		}
		
		public static function isAMinor(value:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			if (!isDate(value)) return false;
			var date:Date = new Date();
			var fullDay:uint = date.getDate();
			var fullMonth:uint = date.month + 1;
			var fullYear:uint = date.getFullYear();
			var inputDay:uint = Number(value.substr(0, 2));
			var inputMonth:uint = Number(value.substr(value.indexOf('/') + 1, 2));
			var inputYear:uint = Number(value.substr(value.lastIndexOf('/') + 1, value.length));
			var isAMinorMonth:Boolean;
			if (fullMonth >= inputMonth) isAMinorMonth = true;
			if (isAMinorMonth && fullDay >= inputDay) inputYear -= 1;
			return (fullYear - inputYear) < 18;
		}
		
		public static function isDefaultLabel(value:String, label:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			return(value == label);
		}
		
		public static function isLink(value:String, required:Boolean = true):Boolean {
			if (required && isEmpty(value)) return false;
			return true;
		}
	}
}