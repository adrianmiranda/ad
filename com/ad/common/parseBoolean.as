package com.ad.common {
	
	public function parseBoolean(value:*):Boolean {
		if (value) { if (value is String) value = value.toLowerCase(); }
		return(value == 'true' || value == '1' || value == 'yes' || value == 'y' || value == 'sim' || value == 's');
	}
}