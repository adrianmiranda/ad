package com.ad.templates {
	import com.ad.proxy.nsproxy;
	
	public class Section extends Viewer {
		
		public function Section() {
			super(true);
		}
		
		protected function back():void {
			
		}
		
		protected function backward():void {
			
		}
		
		protected function setValue(value:Object):void {
			
		}
		
		override public function toString():String {
			return '[Section ' + super.name + ']';
		}
	}
}