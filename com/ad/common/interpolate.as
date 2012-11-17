package com.ad.common
{
	public function interpolate(value:Number, minimum:Number, maximum:Number):Number
	{
		return minimum + (maximum - minimum) * value;
	}
}