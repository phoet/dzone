//
//  Item.h
//  dzone
//
//  Created by Peter Schröder on 12.07.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Item : NSObject {
	
	NSString* title;
	NSString* category;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* category;

@end
