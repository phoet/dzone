#import <Foundation/Foundation.h>

//item>
//<title>Developer Earns Nearly $1,400 in One Day With iAds</title>
//<link>http://feeds.dzone.com/~r/dzone/frontpage/~3/PETamfxSMjg/developer_earns_nearly_1400_in_one_day_with_iads.html</link>
//<description>App Store developer Jason Ting has released data on iAd revenue from the first day of sales for a "utility app" that was released just yesterday, clocking in nearly $1,400 in revenue on an astounding "eCPM" of nearly $150.</description>
//<category>apple</category>
//<category>mobile</category>
//<category>trends</category>
//<pubDate>Fri, 09 Jul 2010 15:18:04 GMT</pubDate>
//<guid isPermaLink="false">http://www.dzone.com/links/443795.html</guid>
//<dc:creator>mitchp</dc:creator>
//<dc:date>2010-07-09T15:18:04Z</dc:date>
//<content:encoded><![CDATA[<a href='http://www.dzone.com/links/rss/developer_earns_nearly_1400_in_one_day_with_iads.html'><img src='http://cdn.dzone.com/images/thumbs/120x90/443795.jpg' style='width:120;height:90;float:left;vertical-align:top;border:1px solid #ccc;' /></a><p style='margin-left: 130px;'>App Store developer Jason Ting has released data on iAd revenue from the first day of sales for a "utility app" that was released just yesterday, clocking in nearly $1,400 in revenue on an astounding "eCPM" of nearly $150. <br/><br/><a href='http://www.dzone.com/links/rss/developer_earns_nearly_1400_in_one_day_with_iads.html'><img src='http://www.dzone.com/links/voteCountImage?linkId=443795' border='0'/></a></p><img src="http://feeds.feedburner.com/~r/dzone/frontpage/~4/PETamfxSMjg" height="1" width="1"/>]]></content:encoded>
//<dz:linkId>443795</dz:linkId>
//<dz:submitDate>2010-07-08T18:07:21Z</dz:submitDate>
//<dz:promoteDate>2010-07-09T15:18:04Z</dz:promoteDate>
//<dz:voteUpCount>4</dz:voteUpCount>
//<dz:voteDownCount>0</dz:voteDownCount>
//<dz:clickCount>50</dz:clickCount>
//<dz:commentCount>0</dz:commentCount>
//<dz:thumbnail>http://www.dzone.com/links/images/thumbs/120x90/443795.jpg</dz:thumbnail>
//<dz:submitter>
//<dz:username>mitchp</dz:username>
//<dz:userimage>http://www.dzone.com/links/images/avatars/478055.gif</dz:userimage>
//</dz:submitter>
@interface Item : NSObject {
	
	NSString* title;
	NSString* link;
	NSString* description;
	NSString* thumbnail;
	NSNumber* linkId;
	NSNumber* voteUpCount;
	NSNumber* voteDownCount;
	NSNumber* clickCount;
	NSNumber* commentCount;
	NSDate* publicationDate;
	NSArray* categories;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* link;
@property(nonatomic, retain) NSString* description;
@property(nonatomic, retain) NSString* thumbnail;
@property(nonatomic, retain) NSNumber* linkId;
@property(nonatomic, retain) NSNumber* voteUpCount;
@property(nonatomic, retain) NSNumber* voteDownCount;
@property(nonatomic, retain) NSNumber* clickCount;
@property(nonatomic, retain) NSNumber* commentCount;
@property(nonatomic, retain) NSDate* publicationDate;
@property(nonatomic, retain) NSArray* categories;

@end
