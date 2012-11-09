package com.ad.common
{
	public function normalize(value:Number, minimum:Number, maximum:Number):Number
	{
		return (value - minimum) / (maximum - minimum);
	}
}