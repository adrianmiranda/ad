package com.ad.templates {
	import com.ad.proxy.nsproxy;
	
	public class Section extends Viewer {
		
		public function Section() {
			super(true);
		}
		
		override public function toString():String {
			return '[Section ' + super.name + ']';
		}
	}
}