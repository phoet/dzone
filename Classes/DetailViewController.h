
#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailViewController : UIViewController {

	Item* currentItem;
	
	IBOutlet UILabel* description;
	IBOutlet UILabel* categories;
	IBOutlet UILabel* publicationDate;
	IBOutlet UILabel* clickCount;
	
	IBOutlet UIImageView* thumbnail;

}

@property (nonatomic, retain) Item* currentItem;

@property (nonatomic, retain) IBOutlet UILabel* description;
@property (nonatomic, retain) IBOutlet UILabel* categories;
@property (nonatomic, retain) IBOutlet UILabel* publicationDate;
@property (nonatomic, retain) IBOutlet UILabel* clickCount;
@property (nonatomic, retain) IBOutlet UIImageView* thumbnail;

@end
