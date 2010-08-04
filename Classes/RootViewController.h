
#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	
	NSMutableArray* items;
	UIActivityIndicatorView* spinner;
	
}

@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) UIActivityIndicatorView* spinner;

@end
