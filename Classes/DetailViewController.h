
#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailViewController : UIViewController {

	Item* currentItem;
	
	IBOutlet UINavigationBar* titleBar;
	IBOutlet UINavigationBar* categoriesBar;
	
	IBOutlet UITextView* description;
	
	IBOutlet UILabel* score;
	IBOutlet UILabel* clicks;
	IBOutlet UILabel* comments;
	
	IBOutlet UIImageView* thumbnail;

}

@property (nonatomic, retain) Item* currentItem;

@property (nonatomic, retain) IBOutlet UINavigationBar* titleBar;
@property (nonatomic, retain) IBOutlet UINavigationBar* categoriesBar;

@property (nonatomic, retain) IBOutlet UITextView* description;

@property (nonatomic, retain) IBOutlet UILabel* score;
@property (nonatomic, retain) IBOutlet UILabel* clicks;
@property (nonatomic, retain) IBOutlet UILabel* comments;

@property (nonatomic, retain) IBOutlet UIImageView* thumbnail;

@end
