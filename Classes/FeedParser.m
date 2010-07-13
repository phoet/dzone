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

+ (NSString*) valueWithName:(NSString *) name fromElement:(TBXMLElement*) element  {
	TBXMLElement* childElement = [TBXML childElementNamed:name parentElement:element];
	NSString* text = [[TBXML textForElement:childElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSLog(@"element %@ has text %@", name, text);
	return text;
}

+ (NSArray*) parseItemsFromURL:(NSString *) urlString{
	TBXML* tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:urlString]] retain];
	TBXMLElement* rootXMLElement = tbxml.rootXMLElement;
	NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
	if (rootXMLElement) {
		NSString* name = [TBXML elementName:rootXMLElement];
		NSLog(@"element has name %@", name);
		TBXMLElement* element = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"channel" parentElement:rootXMLElement]];
		name = [TBXML elementName:element];
		NSLog(@"element has name %@", name);
		do {
			Item* item = [[[Item alloc] init] autorelease];
			item.title = [self valueWithName:@"title" fromElement:element];
			item.category = [self valueWithName:@"category" fromElement:element];
			[array addObject:item];
			
		} while ((element = element->nextSibling));
	}		
	[tbxml release];
	return array;
}

@end
