package com.ad.display {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Triangle extends Leprechaun {
		private var _dimensions:Dimensions;
		private var _color:uint;
		private var _radius:Number;
		private var _width:Number;
		private var _height:Number;
		private var _drawToUp:Boolean;
		
		public function Triangle(color:uint = 0x0, radius:Number = 1, hidden:Boolean = true, drawToUp:Boolean = true) {
			this._dimensions = new Dimensions(radius);
			this._width = hidden ? 0 : this._dimensions.W2;
			this._height = hidden ? 0 : this._dimensions.H2;
			this._drawToUp = drawToUp;
			this._radius = radius;
			this._color = color;
			this.draw();
		}
		
		private function draw():void {
			if (this._drawToUp) {
				super.graphics.beginFill(this._color);
				super.graphics.moveTo(this._width, -this._dimensions.H2 + this._height);
				super.graphics.lineTo(this._dimensions.W2 + this._width, this._dimensions.H2 + this._height);
				super.graphics.lineTo(-this._dimensions.W2 + this._width, this._dimensions.H2 + this._height);
				super.graphics.lineTo(this._width, -this._dimensions.H2 + this._height);
			} else {
                super.graphics.moveTo(this._width, this._dimensions.H2 + this._height);
                super.graphics.lineTo(this._dimensions.W2 + this._width, -this._dimensions.H2 + this._height);
                super.graphics.lineTo(-this._dimensions.W2 + this._width, -this._dimensions.H2 + this._height);
                super.graphics.lineTo(this._width, this._dimensions.H2 + this._height);
			}
			super.graphics.endFill();
		}

		public function set radius(value:Number):void {
			this._dimensions = new Dimensions(radius);
			this._width = hidden ? 0 : this._dimensions.W2;
			this._height = hidden ? 0 : this._dimensions.H2;
			this.draw();
		}

		public function set color(value:uint):void {
			this._color = value;
			this.draw();
		}

		public function toDown():void {
			this._drawToUp = false;
			this.draw();
		}

		public function toUp():void {
			this._drawToUp = true;
			this.draw();
		}
		
		override public function toString():String {
			return '[Triangle ' + super.name + ']';
		}
	}
}

import flash.geom.Rectangle;

internal class Dimensions {
	private var _size:Rectangle;

	public function Dimensions(radius:Number) {
		var height:Number = Math.round(Math.sin(60 * (Math.PI / 180)) * radius);
		this._size = new Rectangle(radius, height);
		this._size.width = this._size.x>>1;
		this._size.height = this._size.y>>1;
	}

	public function get W():Number {
		return this._size.x;
	}

	public function get H():Number {
		return this._size.y;
	}

	public function get W2():Number {
		return this._size.width;
	}

	public function get H2():Number {
		return this._size.height;
	}
}