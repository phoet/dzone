
#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailViewController : UIViewController {

	Item * currentItem;

}

@property (nonatomic, retain) Item * currentItem;

@end
