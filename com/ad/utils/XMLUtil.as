package com.ad.utils {
	
	public final class XMLUtil {
		
		public static function cdata(data:String):XML {
			return new XML('<![CDATA[' + data + ']]>');
		}
		
		public static function mergeXML(source:XML, toMerge:XML):XML
		{
			//Assert.notNull(toMerge, 'toMerge argument must not be null');
			if (source == null)
			{
				return toMerge;
			}
			var nameSpaces:Array = toMerge.namespaceDeclarations();
			for each (var nameSpace:Namespace in nameSpaces)
			{
				if (source.namespace(nameSpace) === undefined)
				{
					source = source.addNamespace(nameSpace);
				}
			}
			var childNodes:XMLList = toMerge.children().copy();
			source.appendChild(childNodes);
			return source;
		}
	}
}