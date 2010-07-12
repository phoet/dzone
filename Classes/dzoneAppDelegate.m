//
//  dzoneAppDelegate.m
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import "dzoneAppDelegate.h"
#import "dzoneViewController.h"
#import "TBXML.h"
#import "Item.h"

@implementation dzoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	viewController.listData = [[[NSMutableArray alloc] init] autorelease];

//	http://www.tbxml.co.uk/TBXML/Guides.html
	
	TBXML * tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:@"http://feeds.dzone.com/dzone/frontpage"]] retain];
	TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
	NSString * name = [TBXML elementName:rootXMLElement];
	NSLog(@"element has name %@", name);
    TBXMLElement* element = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"channel" parentElement:rootXMLElement]];
	do {
		TBXMLElement* titleElement = [TBXML childElementNamed:@"title" parentElement:element];
		NSString * title = [TBXML textForElement:titleElement];	
		NSLog(@"element has title %@", title);
		
		TBXMLElement* categoryElement = [TBXML childElementNamed:@"category" parentElement:element];
		NSString * category = [TBXML textForElement:categoryElement];	
		NSLog(@"element has category %@", category);
		
		Item * item = [[[Item alloc] init] autorelease];
		item.title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		item.category = [category stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		[viewController.listData addObject:item];
	} while ((element = element->nextSibling));
    
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
