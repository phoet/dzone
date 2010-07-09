//
//  dzoneViewController.h
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dzoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

	NSMutableArray *listData;
	
}

@property (nonatomic, retain) NSMutableArray *listData;

@end

