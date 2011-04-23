package com.ad.display {
	
	public class Pie extends Leprechaun {
		
		public function Pie() {
			this.draw();
		}
		
		private function draw():void {
			
		}
		
		override public function toString():String {
			return '[Pie ' + super.name + ']';
		}
	}
}