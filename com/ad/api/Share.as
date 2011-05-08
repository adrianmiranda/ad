package com.ad.api {
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class Share {
		public static const DIGG:Object = { name:'digg', url:'http://digg.com/submit?phase=2&url=' + link + '&title=' + title };
		public static const SPHINN:Object = { name:'sphinn', url:'http://sphinn.com/index.php?c=post&m=submit&link=' + link };
		public static const DELICIOUS:Object = { name:'delicious', url:'http://delicious.com/post?url=' + link + '&title=' + title };
		public static const FACEBOOK:Object = { name:'facebook', url:'http://www.facebook.com/share.php?u=' + link + '&t=' + title };
		public static const GOOGLEBOOKMARKS:Object = { name:'googlebookmarks', url:'http://www.google.com/bookmarks/mark?op=edit&bkmk=' + link + '&title='+title+'&annotation='+description };
		public static const LINKEDIN:Object = { name:'linkedin', url:'http://www.linkedin.com/shareArticle?mini=true&url='+link+'&title=' + title + '&source='+description };
		public static const MYSPACE:Object = { name:'myspace', url:'http://www.myspace.com/Modules/PostTo/Pages/?u=' + link + '&t=' + title };
		public static const NETVIBES:Object = { name:'netvibes', url:'http://www.netvibes.com/share?title=' + title + '&url=' + link };
		public static const REDDIT:Object = { name:'reddit', url:'http://reddit.com/submit?url=' + link + '&title=' + title };
		public static const STUMPLEEUP:Object = { name:'stumpleeup', url:'http://www.stumbleupon.com/submit?url=' + link + '&title=' + title };
		public static const TECHNORATI:Object = { name:'technorati', url:'http://technorati.com/faves?add=' + link + ' ' + title };
		public static const TWITTER:Object = { name:'twitter', url:'http://twitter.com/home?status='+title+'%20-%20' + link + '' };
		public static const YAHOOBOOKMARKS:Object = { name:'yahoobookmarks', url:'http://bookmarks.yahoo.com/toolbar/savebm?u=' + link + '&t=' + title + '&opener=bm&ei=UTF-8&d=' + description };
		public static const YAHOOBUZZ:Object = { name:'yahoobuzz', url:'http://buzz.yahoo.com/submit/?submitUrl=' + link + '&submitHeadline=&submitSummary=' + description + '&submitCategory=science&submitAssetType=text' };
		public static const ORKUT:Object = { name:'orkut', url:'http://promote.orkut.com/preview?nt=orkut.com&tt=' + title + '&du=' + link + '&cn=' + description };
		
		private static const link:String = '{link}';
		private static const title:String = '{title}';
		private static const description:String = '{description}';
		
		public static function share(service:Object, linkShare:String, titleShare:String = '', descriptionShare:String = ''):void {
			var request:URLRequest = new URLRequest(getUrlToShare(service, linkShare, titleShare, descriptionShare));
			try {            
				navigateToURL(request, '_blank');
			} catch (event:Error) {
				trace('ERROR: navigateToURL >', request.url);
			}
		}
		
		public static function getUrlToShare(service:Object, linkShare:String, titleShare:String = '', descriptionShare:String = ''):String {
			titleShare = (titleShare == '') ?  linkShare : titleShare;
			descriptionShare = (descriptionShare == '') ?  linkShare : descriptionShare;
			var url:String = service.url.replace(link, encodeURIComponent(linkShare)).replace(title, encodeURIComponent(titleShare)).replace(description, encodeURIComponent(descriptionShare));
			return url;
		}
	}
}