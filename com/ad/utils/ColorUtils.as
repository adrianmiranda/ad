package com.ad.utils {
	import __AS3__.vec.Vector;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class ColorUtils {
		public static function tint(rgb:uint = 0, amount:Number = 1, alpha:Number = 1):ColorTransform {
			amount = Math.max(0, Math.min(amount, 1));
			alpha = Math.max(0, Math.min(alpha, 1));
			var r:Number = ((rgb >> 16) & 0xFF) * amount;
			var g:Number = ((rgb >> 8) & 0xFF) * amount;
			var b:Number = (rgb & 0xFF) * amount;
			var a:Number = 1 - amount;
			return new ColorTransform(a, a, a, alpha, r, g, b, 0);
		}
		
		public static function extractRGB(color24:uint):Vector.<uint> {
			var r:uint = color24 >> 16;
			var g:uint = color24 >> 8 & 255;
			var b:uint = color24 & 255;
			var flush:Vector.<uint> = new Vector.<uint>;
			flush.push(r);
			flush.push(g);
			flush.push(b);
			return flush;
		}
		
		public static function extractARGB(color32:uint):Vector.<uint> {
			var a:uint = color32 >> 24;
			var r:uint = color32 >> 16 & 255;
			var g:uint = color32 >> 8 & 255;
			var b:uint = color32 & 255;
			var flush:Vector.<uint> = new Vector.<uint>;
			flush.push(a);
			flush.push(r);
			flush.push(g);
			flush.push(b);
			return flush;
		}
		
		public static function combineRGB(r:uint, g:uint, b:uint):uint {
			return r << 16 | g << 8 | b;
		}
		
		public static function combineARGB(a:uint, r:uint, g:uint, b:uint):uint {
			return a << 24 | r << 16 | g << 8 | b;
		}
		
		/*public static function combineHSV(h:int, s:Number, v:Number):uint {
			return rgb.apply(null, HSVtoRGB(h, s, v));
		}*/
		
		public static function RGBtoCMYK(r:Number, g:Number, b:Number):Array {
			var c:Number = 0, m:Number = 0, y:Number = 0, k:Number = 0, z:Number = 0;
			c = 255 - r;
			m = 255 - g;
			y = 255 - b;
			k = 255;
			
			if (c < k) k = c;
			if (m < k) k = m;
			if (y < k) k = y;
			if (k == 255) {
				c = 0;
				m = 0;
				y = 0;
			} else {
				c = Math.round(255 * (c - k) / (255 - k));
				m = Math.round(255 * (m - k) / (255 - k));
				y = Math.round(255 * (y - k) / (255 - k));
			}
			return [c, m, y, k];
		}
		
		public static function CMYKtoRGB(c:Number, m:Number, y:Number, k:Number):Array {
			c = 255 - c;
			m = 255 - m;
			y = 255 - y;
			k = 255 - k; 
			return [(255 - c) * (255 - k) / 255, (255 - m) * (255 - k) / 255, (255 - y) * (255 - k) / 255];
		}
		
		/*public static function RGBtoHSV(r:Number, g:Number, b:Number):Array {
			r /= 255; g /= 255; b /= 255;
			var h:Number = 0, s:Number = 0, v:Number = 0;
			var x:Number, y:Number;
			if (r >= g) x = r; else x = g; if (b > x) x = b;
			if (r <= g) y = r; else y = g; if (b < y) y = b;
			v = x;
			var c:Number = xy;
			if (x == 0) s = 0; else s = c / x;
			if (s != 0) {
				if (r == x) {
					h = (gb) / c;
				} else {
					if (g == x) {
						h = 2 + (br) / c;
					} else {
						if (b == x) {
							h = 4 + (rg) / c;
						}
					}
				}
				h = h * 60;
				if (h < 0) h = h + 360;
			}
			return [h, s, v];
		}*/
		
		public static function HSVtoRGB(h:Number, s:Number, v:Number):Array {
			var r:Number = 0, g:Number = 0, b:Number = 0;
			var i:Number, x:Number, y:Number, z:Number;
			if (s < 0) s = 0; if (s > 1) s = 1; if (v < 0) v = 0; if (v > 1) v = 1;
			h = h % 360; if (h < 0) h += 360; h /= 60;
			i = h >> 0;
			x = v * (1 - s); y = v * (1 - s * (h - i)); z = v * (1 - s * (1 - h + i));
			switch (i) {
				case 0: r = v; g = z; b = x; break;
				case 1: r = y; g = v; b = x; break;
				case 2: r = x; g = v; b = z; break;
				case 3: r = x; g = y; b = v; break;
				case 4: r = z; g = x; b = v; break;
				case 5: r = v; g = x; b = y; break;
			}
			return [r * 255 >> 0, g * 255 >> 0, b * 255 >> 0];
		}
	}
}