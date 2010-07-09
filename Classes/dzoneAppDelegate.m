//
//  dzoneAppDelegate.m
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import "dzoneAppDelegate.h"
#import "dzoneViewController.h"
#import "XMLParser.h"

@implementation dzoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	NSURL *url = [[NSURL alloc] initWithString:@"http://feeds.dzone.com/dzone/frontpage"];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	//Initialize the delegate.
	XMLParser *parser = [[XMLParser alloc] initXMLParser: viewController];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success){
		NSLog(@"No Errors");
	} else {
		NSLog(@"Error Error Error!!!");
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
