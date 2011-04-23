package com.ad.utils {
	
	public final class Conversion {
		
		/**
		 * Converte bits em kilobits.
		 * @param bits O número de bits.
		 * @return Number O número de bytes.
		 */
		public static function bitsToBytes(bits:Number):Number {
			return bits / 8;
		}
		
		/**
		 * Converte bits em kilobits.
		 * @param bits O número de bits.
		 * @return Number O número de kilobits.
		 */
		public static function bitsToKilobits(bits:Number):Number {
			return bits / 1024;
		}
		
		/**
		 * Converte bits em kilobytes.
		 * @param bits O número de bits.
		 * @return Number O número de kilobytes.
		 */
		public static function bitsToKilobytes(bits:Number):Number {
			return bits / 8192;
		}
		
		/**
		 * Converte bytes em bits.
		 * @param bytes O número de bytes.
		 * @return Number O número de bits.
		 */
		public static function bytesToBits(bytes:Number):Number {
			return bytes * 8;
		}
		
		/**
		 * Converte bytes em kilobits.
		 * @param bytes O número de bytes.
		 * @return Number O número de kilobits.
		 */
		public static function bytesToKilobits(bytes:Number):Number {
			return bytes / 128;
		}
		
		/**
		 * Converte bytes em kilobytes.
		 * @param bytes O número de bytes.
		 * @return Number O número de kilobytes.
		 */
		public static function bytesToKilobytes(bytes:Number):Number {
			return bytes / 1024;
		}
		
		/**
		 * Converte kilobits em bits.
		 * @param kilobits O número de kilobits.
		 * @return Number O número de bits.
		 */
		public static function kilobitsToBits(kilobits:Number):Number {
			return kilobits * 1024;
		}
		
		/**
		 * Converte kilobits em bytes.
		 * @param kilobits O número de kilobytes.
		 * @return Number O número de bytes.
		 */
		public static function kilobitsToBytes(kilobits:Number):Number {
			return kilobits * 128;
		}
		
		/**
		 * Converte kilobits em kilobytes.
		 * @param kilobits O número de kilobits.
		 * @return Number O número de kilobytes.
		 */
		public static function kilobitsToKilobytes(kilobits:Number):Number {
			return kilobits / 8;
		}
		
		/**
		 * Converte kilobytes em bits.
		 * @param kilobytes O número de kilobytes.
		 * @return Number O número de bits.
		 */
		public static function kilobytesToBits(kilobytes:Number):Number {
			return kilobytes * 8192;
		}
		
		/**
		 * Converte kilobytes em bytes.
		 * @param kilobytes O número de kilobytes.
		 * @return Number O número de bytes.
		 */
		public static function kilobytesToBytes(kilobytes:Number):Number {
			return kilobytes * 1024;
		}
		
		/**
		 * Converte kilobytes em kilobits.
		 * @param kilobytes O número de kilobytes.
		 * @return Number O número de kilobits.
		 */
		public static function kilobytesToKilobits(kilobytes:Number):Number {
			return kilobytes * 8;
		}
		
		/**
		 * Converte milissegundos em segundos.
		 * @param milliseconds O número de milissegundos.
		 * @return Number O número de segundos.
		 */
		public static function millisecondsToSeconds(milliseconds:Number):Number {
			return milliseconds / 1000;
		}
		
		/**
		 * Converte milissegundos em minutos.
		 * @param milliseconds O número de milissegundos.
		 * @return Number O número de minutos.
		 */
		public static function millisecondsToMinutes(milliseconds:Number):Number {
			return Conversion.secondsToMinutes(Conversion.millisecondsToSeconds(milliseconds));
		}
		
		/**
		 * Converte milissegundos em horas.
		 * @param milliseconds O número de milissegundos.
		 * @return Number O número de horas.
		 */
		public static function millisecondsToHours(milliseconds:Number):Number {
			return Conversion.minutesToHours(Conversion.millisecondsToMinutes(milliseconds));
		}
		
		/**
		 * Converte milissegundos em dias.
		 * @param milliseconds O número de milissegundos.
		 * @return Number O número de dias.
		 */
		public static function millisecondsToDays(milliseconds:Number):Number {
			return Conversion.hoursToDays(Conversion.millisecondsToHours(milliseconds));
		}
		
		/**
		 * Converte segundos em milissegundos.
		 * @param seconds O número de segundos.
		 * @return Number O número de milissegundos.
		 */
		public static function secondsToMilliseconds(seconds:Number):Number {
			return seconds * 1000;
		}
		
		/**
		 * Converte segundos em minutos.
		 * @param seconds O número de segundos.
		 * @return Number O número de minutos.
		 */
		public static function secondsToMinutes(seconds:Number):Number {
			return seconds / 60;
		}
		
		/**
		 * Converte segundos em horas.
		 * @param seconds O número de segundos.
		 * @return Number O número de horas.
		 */
		public static function secondsToHours(seconds:Number):Number {
			return Conversion.minutesToHours(Conversion.secondsToMinutes(seconds));
		}
		
		/**
		 * Converte segundos em dias.
		 * @param seconds O número de segundos.
		 * @return Number O número de dias.
		 */
		public static function secondsToDays(seconds:Number):Number {
			return Conversion.hoursToDays(Conversion.secondsToHours(seconds));
		}
		
		/**
		 * Converte minutos em milissegundos.
		 * @param minutes O número de minutos.
		 * @return Number O número de milissegundos.
		 */
		public static function minutesToMilliseconds(minutes:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.minutesToSeconds(minutes));
		}
		
		/**
		 * Converte minutos em segundos.
		 * @param minutes O número de minutos.
		 * @return Number O número de segundos.
		 */
		public static function minutesToSeconds(minutes:Number):Number {
			return minutes * 60;
		}
		
		/**
		 * Converte minutos em horas.
		 * @param minutes O número de minutos.
		 * @return Number O número de horas.
		 */
		public static function minutesToHours(minutes:Number):Number {
			return minutes / 60;
		}
		
		/**
		 * Converte minutos em dias.
		 * @param minutes O número de minutos.
		 * @return Number O número de dias.
		 */
		public static function minutesToDays(minutes:Number):Number {
			return Conversion.hoursToDays(Conversion.minutesToHours(minutes));
		}
		
		/**
		 * Converte horas em milissegundos.
		 * @param hours O número de horas.
		 * @return Number O número de milissegundos.
		 */
		public static function hoursToMilliseconds(hours:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.hoursToSeconds(hours));
		}
		
		/**
		 * Converte horas em segundos.
		 * @param hours O número de horas.
		 * @return Number O número de segundos.
		 */
		public static function hoursToSeconds(hours:Number):Number {
			return Conversion.minutesToSeconds(Conversion.hoursToMinutes(hours));
		}
		
		/**
		 * Converte horas em minutos.
		 * @param hours O número de horas.
		 * @return Number O número de minutos.
		 */
		public static function hoursToMinutes(hours:Number):Number {
			return hours * 60;
		}
		
		/**
		 * Converte horas em dias.
		 * @param hours O número de horas.
		 * @return Number O número de dias.
		 */
		public static function hoursToDays(hours:Number):Number {
			return hours / 24;
		}
		
		/**
		 * Converte dias em milissegundos.
		 * @param days O número de dias.
		 * @return Number O número de milissegundos.
		 */
		public static function daysToMilliseconds(days:Number):Number {
			return Conversion.secondsToMilliseconds(Conversion.daysToSeconds(days));
		}
		
		/**
		 * Converte dias em segundos.
		 * @param days O número de dias.
		 * @return Number O número de segundos.
		 */
		public static function daysToSeconds(days:Number):Number {
			return Conversion.minutesToSeconds(Conversion.daysToMinutes(days));
		}
		
		/**
		 * Converte dias em minutos.
		 * @param days O número de dias
		 * @return Number O número de minutos.
		 */
		public static function daysToMinutes(days:Number):Number {
			return Conversion.hoursToMinutes(Conversion.daysToHours(days));
		}
		
		/**
		 * Converte dias em horas.
		 * @param days O número de dias
		 * @return Number O número de horas.
		 */
		public static function daysToHours(days:Number):Number {
			return days * 24;
		}
		
		/**
		 * Converte graus em radianos.
		 * @param degrees O número de graus.
		 * @return Number O número de radianos.
		 */
		public static function degreesToRadians(degrees:Number):Number {
			return degrees * (Math.PI / 180);
		}
		
		/**
		 * Converte radianos em graus.
		 * @param radians O número de radianos.
		 * @return Number O número de graus.
		 */
		public static function radiansToDegrees(radians:Number):Number {
			return radians * (180 / Math.PI);
		}
		
		/**
		 * Converte centímetros em metros.
		 * @param centimeters O número de centímetros.
		 * @return Number O número de metros.
		 */
		public static function centimetersToMeters(centimeters:Number):Number {
			return centimeters / 100;
		}
		
		/**
		 * Converte metros em centímetros.
		 * @param meters O número de metros.
		 * @return Number O número de centímetros.
		 */
		public static function metersToCentimeters(meters:Number):Number {
			return meters * 100;
		}
		
		/**
		 * Converte metros em pés.
		 * @param meters O número de metros.
		 * @param round Determina se retorna as polegadas junto ao valor de pés.
		 * @return uint O número de pés.
		 */
		public static function metersToFeet(meters:Number, round:Boolean = true):Number {
			var feet:uint = Math.round(Conversion.metersToCentimeters(meters) / 30.48);
			var inches:uint = Math.round((Conversion.metersToCentimeters(meters) - (feet * 30.48)) / 2.54);
			var feetAndInches:Number = Number(String(feet).concat('.' + inches));
			return (round) ? feet : feetAndInches;
		}
		
		/**
		 * Converte milhas em quilômetros.
		 * @param miles O número de milhas.
		 * @return Number O número de quilômetros.
		 */
		public static function milesToKilometers(miles:Number):Number {
			return miles * 1.609344;
		}
		
		/**
		 * Converte quilômetros em milhas.
		 * @param kilometers O número de quilômetros.
		 * @return Number O número de milhas.
		 */
		public static function kilometersToMiles(kilometers:Number):Number {
			return kilometers / 1.609344;
		}
		
		/**
		 * Converte celsius em fahrenheit.
		 * @param degrees O número de graus em celsius.
		 * @return Number O número de graus em fahrenheit.
		 */
		public static function celsiusToFahrenheit(degrees:Number):Number {
			return (degrees * 1.8) + 32;
		}
		
		/**
		 * Converte fahrenheit em celsius.
		 * @param degrees O número de graus em fahrenheit.
		 * @return Number O número de graus em celsius.
		 */
		public static function fahrenheitToCelsius(degrees:Number):Number {
			return (degrees - 32) / 1.8;
		}
	}
}