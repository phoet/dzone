//
//  FeedParser.h
//  dzone
//
//  Created by Peter Schröder on 12.07.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedParser : NSObject {

}

+ (NSArray*) parseItemsFromURL:(NSString *) urlString;

@end
