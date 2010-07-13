//
//  dzoneViewController.h
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface dzoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

	NSMutableArray *listData;
	
	Item * currentItem;
	
	IBOutlet UILabel *title;
	
}

@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) Item *currentItem;

@end

