package com.ad.common {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	public function moveRegistrationPoint(target:DisplayObject, registrationX:Number, registrationY:Number, showRegistration:Boolean = false):void {
		target.transform.matrix = new Matrix(1, 0, 0, 1, -registrationX, -registrationY);
		if (showRegistration) {
			var registrationPoint:Shape = new Shape();
			registrationPoint.graphics.lineStyle(2, 0x000000);
			registrationPoint.graphics.moveTo(-5, -5);
			registrationPoint.graphics.lineTo(5, 5);
			registrationPoint.graphics.moveTo(-5, 5);
			registrationPoint.graphics.lineTo(5, -5);
			target.parent.addChild(registrationPoint);
		}
	}
}