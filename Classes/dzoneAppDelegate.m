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

#define DZONE_URL @"http://feeds.dzone.com/dzone/frontpage"

@implementation dzoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	// TODO check why this can't be done in the viewController init method
	viewController.listData = [[[NSMutableArray alloc] init] autorelease];
	
	NSArray * items = [FeedParser parseItemsFromURL: DZONE_URL];
	if ([items count] > 0 ) {
		for (Item * item in items) {
			[viewController.listData addObject:item];
		}
	} else {
		NSString* errorMessage = [NSString stringWithFormat:@"Check your networking configuration, could not load %@", DZONE_URL];
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
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
