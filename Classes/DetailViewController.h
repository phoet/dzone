
#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailViewController : UIViewController {

	Item* currentItem;
	
	IBOutlet UILabel* description;
	IBOutlet UILabel* categories;
	IBOutlet UILabel* publicationDate;

}

@property (nonatomic, retain) Item* currentItem;

@property (nonatomic, retain) IBOutlet UILabel* description;
@property (nonatomic, retain) IBOutlet UILabel* categories;
@property (nonatomic, retain) IBOutlet UILabel* publicationDate;

@end
