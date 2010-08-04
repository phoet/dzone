
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UINavigationBarDelegate> {

	NSDictionary* currentItem;
	
	IBOutlet UINavigationBar* titleBar;
	IBOutlet UINavigationBar* categoriesBar;
	
	IBOutlet UITextView* description;
	
	IBOutlet UILabel* scores;
	IBOutlet UILabel* clicks;
	IBOutlet UILabel* comments;
	
	IBOutlet UIImageView* thumbnail;

}

@property (nonatomic, retain) NSDictionary* currentItem;

@property (nonatomic, retain) IBOutlet UINavigationBar* titleBar;
@property (nonatomic, retain) IBOutlet UINavigationBar* categoriesBar;

@property (nonatomic, retain) IBOutlet UITextView* description;

@property (nonatomic, retain) IBOutlet UILabel* scores;
@property (nonatomic, retain) IBOutlet UILabel* clicks;
@property (nonatomic, retain) IBOutlet UILabel* comments;

@property (nonatomic, retain) IBOutlet UIImageView* thumbnail;

@end
