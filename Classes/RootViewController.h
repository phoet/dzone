
#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITableViewDelegate> {
	
	NSMutableArray* items;
	UIActivityIndicatorView* spinner;
	NSNumber* limit;
	
}

- (IBAction) doReload;

@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) UIActivityIndicatorView* spinner;
@property (nonatomic, retain) NSNumber* limit;

@end
