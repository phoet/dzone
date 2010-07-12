//
//  FeedParser.m
//  dzone
//
//  Created by Peter Schröder on 12.07.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//

#import "FeedParser.h"
#import "TBXML.h"
#import "Item.h"

@implementation FeedParser

+ (NSString*) valueWithName:(NSString *) name fromElement:(TBXMLElement *) element  {
	TBXMLElement* titleElement = [TBXML childElementNamed:@"title" parentElement:element];
	NSString * title = [TBXML textForElement:titleElement];
	title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSLog(@"element has title %@", title);
	return title;
}

+ (NSArray*) parseItemsFromURL:(NSString *) urlString{
	TBXML * tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:urlString]] retain];
	// TODO check for error and report it back
	TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
	NSString * name = [TBXML elementName:rootXMLElement];
	NSLog(@"element has name %@", name);
	TBXMLElement* element = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"channel" parentElement:rootXMLElement]];
	NSMutableArray * array = [[[NSMutableArray alloc] init] autorelease];
	do {
		Item * item = [[[Item alloc] init] autorelease];
		item.title = [self valueWithName:@"title" fromElement:element];
		item.category = [self valueWithName:@"category" fromElement:element];
		[array addObject:item];
		
	} while ((element = element->nextSibling));
	return array;
}
@end
