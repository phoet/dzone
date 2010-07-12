//
//  dzoneAppDelegate.m
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import "dzoneAppDelegate.h"
#import "dzoneViewController.h"
#import "FeedParser.h"
#import "Item.h"

@implementation dzoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	viewController.listData = [[[NSMutableArray alloc] init] autorelease];
	
	NSArray * items = [FeedParser parseItemsFromURL: @"http://feeds.dzone.com/dzone/frontpage"];
	for (Item * item in items) {
		[viewController.listData addObject:item];
	}

    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
