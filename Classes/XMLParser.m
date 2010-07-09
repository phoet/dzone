//
//  XMLParser.m
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
// http://www.iphonesdkarticles.com/2008/11/parsing-xml-files.html

#import "XMLParser.h"
#import "dzoneViewController.h"

@implementation XMLParser

- (XMLParser *) initXMLParser:(dzoneViewController *)vc {
	[super init];
	
	viewController = vc;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"item"]) {
		NSLog(@"Found item!");
		if (viewController.listData == nil) {
			NSLog(@"init listData!");
			viewController.listData = [[[NSMutableArray alloc] init] autorelease];
		}
	}
	else if([elementName isEqualToString:@"title"]) {
		NSLog(@"Found title!");
		currentElementName = [elementName autorelease];
	} else {
		currentElementName = nil;
	}
	
	NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSLog(@"Found chars for controller %@", viewController);
	NSLog(@"Found chars %@", viewController.listData);
	NSLog(@"Found chars for element %@", currentElementName);
	
	if(viewController.listData && currentElementName){
		NSLog(@"Adding %@", string);
		if(!currentElementValue){
			currentElementValue = [[NSMutableString alloc] initWithString:string];
		}
		[currentElementValue appendString:string];
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	NSLog(@"Ending Element: %@", elementName);
	
	if([elementName isEqualToString:@"title"]) {
		NSLog(@"Found end of title, adding %@", currentElementValue);
		[viewController.listData addObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		
		[currentElementValue release];
		currentElementValue = nil;
	}
}
@end