//
//  XMLParser.h
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//
#import <UIKit/UIKit.h>

@class dzoneViewController;

@interface XMLParser : NSObject {
	
	NSMutableString *currentElementValue;
	
	NSString *currentElementName;
	
	dzoneViewController *viewController;
}

- (XMLParser *) initXMLParser:(dzoneViewController *) vc;
@end