package com.ad.misc {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * @author Adrian C. Miranda
	 * @see http://en.wikipedia.org/wiki/Radian#Advantages_of_measuring_in_radians
	 */
	public final class Angle {
		private const PI:Number = Math.PI;
		private const D90:Number = PI * 2;
		private const radiansFactor:Number = PI / 180;
		private const degreesFactor:Number = 180 / PI;
		private const atan2:Function = Math.atan2;
		private const atan:Function = Math.atan;
		private const cos:Function = Math.cos;
		private const sin:Function = Math.sin;
		private const max:Function = Math.max;
		private const min:Function = Math.min;
		
		public function Angle(radius:Number) {
			
		}
		
		public function findAngle(length:Number):Number {
			return D90 / length;
		}
		
		public function update(angle:Number, radius:Point):Point {
			var id:int, point:Point = new Point(0, 0);
			angle = radians(max(0, min(angle, 360)));
			for (id = 0; id <= angle; id++) {
				point.x = cos(angle) * radius.x;
				point.y = sin(angle) * radius.y;
			}
			return point;
		}
		
		public static function radians(degrees:Number):Number {
			return degrees * radiansFactor;
		}
		
		public static function degrees(radians:Number):Number {
			return radians * degreesFactor;
		}
		
		public static function arctangent(point1:Point, point2:Point):Number {
			return -atan2(point2.x - point1.x, point2.y - point1.y);
		}
		
		private function change():void {
			super.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}