
#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITableViewDelegate> {
	
	NSMutableArray* items;
	UIActivityIndicatorView* spinner;
	
}

- (IBAction) doReload;

@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) UIActivityIndicatorView* spinner;

@end
