//
//  dzoneAppDelegate.h
//  dzone
//
//  Created by Peter Schröder on 09.07.10.
//  Copyright blau Mobilfunk GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dzoneViewController;

@interface dzoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    dzoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet dzoneViewController *viewController;

@end

