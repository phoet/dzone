
#import "FeedParser.h"
#import "TBXML.h"
#import "Item.h"

@implementation FeedParser

+ (NSString*) valueWithName:(NSString*) name fromElement:(TBXMLElement*) element  {
	TBXMLElement* childElement = [TBXML childElementNamed:name parentElement:element];
	NSString* text = [[TBXML textForElement:childElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return text;
}

+ (NSArray*) arrayWithName:(NSString*) name fromElement:(TBXMLElement*) element  {
	TBXMLElement* childElement = [TBXML childElementNamed:name parentElement:element];
	NSMutableArray* array = [[NSMutableArray alloc] init];
	do {	
		NSString* currentName = [TBXML elementName:childElement];
		if ([currentName isEqualToString:name]) {
			NSString* text = [[TBXML textForElement:childElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			NSLog(@"array element %@ has text %@", currentName, text);
			[array addObject:text];
		}
		
	} while (childElement = childElement->nextSibling);
	return array;
}

+ (NSArray*) parseItemsFromURL:(NSString *) urlString{
	TBXML* tbxml = [[TBXML tbxmlWithURL:[NSURL URLWithString:urlString]] retain];
	TBXMLElement* rootXMLElement = tbxml.rootXMLElement;
	NSMutableArray* array = [[NSMutableArray alloc] init];
	if (rootXMLElement) {
		NSString* name = [TBXML elementName:rootXMLElement];
		NSLog(@"element has name %@", name);
		TBXMLElement* element = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"channel" parentElement:rootXMLElement]];
		name = [TBXML elementName:element];
		NSLog(@"element has name %@", name);
		do {
			Item* item = [[[Item alloc] init] autorelease];
			item.title = [self valueWithName:@"title" fromElement:element];
			item.categories = [self arrayWithName:@"category" fromElement:element];
			[array addObject:item];
			
		} while (element = element->nextSibling);
	}		
	[tbxml release];
	return array;
}

@end
