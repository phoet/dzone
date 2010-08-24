//
//  BrowserViewController.m
//  dzone
//
//  Created by Peter Schröder on 24.08.10.
//  Copyright 2010 blau Mobilfunk GmbH. All rights reserved.
//

#import "BrowserViewController.h"


@implementation BrowserViewController

@synthesize webView;
@synthesize currentItem;
@synthesize spinner;

- (void) viewWillAppear:(BOOL)animated {
	self.title = @"Browser Details";

	[self.spinner startAnimating];
	
	[self.webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:[self.currentItem valueForKey:@"deep_link"]]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"web view finished loading");
	[self.spinner stopAnimating];
	[self.spinner removeFromSuperview];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
