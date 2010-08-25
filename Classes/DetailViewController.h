
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UINavigationBarDelegate> {

	NSDictionary* currentItem;
	
	IBOutlet UITextView* description;
	
	IBOutlet UILabel* scores;
	IBOutlet UILabel* clicks;
	IBOutlet UILabel* comments;
	IBOutlet UILabel* itemTitle;
	IBOutlet UILabel* categories;
	
	IBOutlet UIImageView* thumbnail;
	
	IBOutlet UIActivityIndicatorView* spinner;

}

- (IBAction)showInBrowser:(id)sender;

@property (nonatomic, retain) NSDictionary* currentItem;

@property (nonatomic, retain) IBOutlet UITextView* description;

@property (nonatomic, retain) IBOutlet UILabel* itemTitle;
@property (nonatomic, retain) IBOutlet UILabel* categories;
@property (nonatomic, retain) IBOutlet UILabel* scores;
@property (nonatomic, retain) IBOutlet UILabel* clicks;
@property (nonatomic, retain) IBOutlet UILabel* comments;

@property (nonatomic, retain) IBOutlet UIImageView* thumbnail;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;

@end
