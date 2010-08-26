//
//  BrowserViewController.h
//  dzone
//
//  Created by Peter Schröder on 24.08.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrowserViewController : UIViewController  <UINavigationBarDelegate, UIWebViewDelegate> {
	
	NSDictionary* currentItem;
	
	IBOutlet UIWebView* webView;
	IBOutlet UIActivityIndicatorView* spinner;
}

- (IBAction) vote;

@property (nonatomic, retain) NSDictionary* currentItem;
@property (nonatomic, retain) UIWebView* webView;
@property (nonatomic, retain) UIActivityIndicatorView* spinner;

@end
