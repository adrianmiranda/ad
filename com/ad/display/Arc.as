package com.ad.display {
	
	public class Arc extends Pie {
		
		public function Arc() {
			this.draw();
		}
		
		private function draw():void {
			
		}
		
		override public function toString():String {
			return '[Arc ' + super.name + ']';
		}
	}
}