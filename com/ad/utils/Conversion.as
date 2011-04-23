package com.ad.utils {
	
	public final class Conversion {
		
		public static function bitsToBytes(bits:Number):Number {
			return bits / 8;
		}
		
		public static function bitsToKilobits(bits:Number):Number {
			return bits / 1024;
		}
		
		public static function bitsToKilobytes(bits:Number):Number {
			return bits / 8192;
		}
		
		public static function bytesToBits(bytes:Number):Number {
			return bytes * 8;
		}
		
		public static function bytesToKilobits(bytes:Number):Number {
			return bytes / 128;
		}
		
		public static function bytesToKilobytes(bytes:Number):Number {
			return bytes / 1024;
		}
		
		public static function kilobitsToBits(kilobits:Number):Number {
			return kilobits * 1024;
		}
		
		public static function kilobitsToBytes(kilobits:Number):Number {
			return kilobits * 128;
		}
		
		public static function kilobitsToKilobytes(kilobits:Number):Number {
			return kilobits / 8;
		}
		
		public static function kilobytesToBits(kilobytes:Number):Number {
			return kilobytes * 8192;
		}
		
		public static function kilobytesToBytes(kilobytes:Number):Number {
			return kilobytes * 1024;
		}
		
		public static function kilobytesToKilobits(kilobytes:Number):Number {
			return kilobytes * 8;
		}
		
		public static function millisecondsToSeconds(milliseconds:Number):Number {
			return milliseconds / 1000;
		}
		
		public static function millisecondsToMinutes(milliseconds:Number):Number {
			return Conversion.secondsToMinutes(Conversion.millisecondsToSeconds(milliseconds));
		}
		
		public static function millisecondsToHours(milliseconds:Number):Number {
			return Conversion.minutesToHours(Conversion.millisecondsToMinutes(milliseconds));
		}
		
		public static function millisecondsToDays(milliseconds:Number):Number {
			return Conversion.hoursToDays(Conversion.millisecondsToHours(milliseconds));
		}
		
		public static function secondsToMilliseconds(seconds:Number):Number {
			return seconds * 1000;
		}
		
		public static function secondsToMinutes(seconds:Number):Number {
			return seconds / 60;
		}
		
		public static function secondsToHours(seconds:Number):Number {
			return Conversion.minutesToHours(Conversion.secondsToMinutes(seconds));
		}
		
		public static function secondsToDays(seconds:Number):Number {
			return Conversion.hoursToDays(Conversion.secondsToHours(seconds));
		}
		
		public static function minutesToMilliseconds(minutes:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.minutesToSeconds(minutes));
		}
		
		public static function minutesToSeconds(minutes:Number):Number {
			return minutes * 60;
		}
		
		public static function minutesToHours(minutes:Number):Number {
			return minutes / 60;
		}
		
		public static function minutesToDays(minutes:Number):Number {
			return Conversion.hoursToDays(Conversion.minutesToHours(minutes));
		}
		
		public static function hoursToMilliseconds(hours:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.hoursToSeconds(hours));
		}
		
		public static function hoursToSeconds(hours:Number):Number {
			return Conversion.minutesToSeconds(Conversion.hoursToMinutes(hours));
		}
		
		public static function hoursToMinutes(hours:Number):Number {
			return hours * 60;
		}
		
		public static function hoursToDays(hours:Number):Number {
			return hours / 24;
		}
		
		public static function daysToMilliseconds(days:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.daysToSeconds(days));
		}
		
		public static function daysToSeconds(days:Number):Number {
			return Conversion.minutesToSeconds(Conversion.daysToMinutes(days));
		}
		
		public static function daysToMinutes(days:Number):Number {
			return Conversion.hoursToMinutes(Conversion.daysToHours(days));
		}
		
		public static function daysToHours(days:Number):Number {
			return days * 24;
		}
		
		public static function degreesToRadians(degrees:Number):Number {
			return degrees * (Math.PI / 180);
		}
		
		public static function radiansToDegrees(radians:Number):Number {
			return radians * (180 / Math.PI);
		}
		
		public static function centimetersToMeters(centimeters:Number):Number {
			return centimeters / 100;
		}
		
		public static function metersToCentimeters(meters:Number):Number {
			return meters * 100;
		}
		
		public static function metersToFeet(meters:Number, round:Boolean = true):Number {
			var feet:uint = Math.round(Conversion.metersToCentimeters(meters) / 30.48);
			var inches:uint = Math.round((Conversion.metersToCentimeters(meters) - (feet * 30.48)) / 2.54);
			var feetAndInches:Number = Number(String(feet).concat('.' + inches));
			return (round) ? feet : feetAndInches;
		}
		
		public static function milesToKilometers(miles:Number):Number {
			return miles * 1.609344;
		}
		
		public static function kilometersToMiles(kilometers:Number):Number {
			return kilometers / 1.609344;
		}
		
		public static function celsiusToFahrenheit(degrees:Number):Number {
			return (degrees * 1.8) + 32;
		}
		
		public static function fahrenheitToCelsius(degrees:Number):Number {
			return (degrees - 32) / 1.8;
		}
	}
}