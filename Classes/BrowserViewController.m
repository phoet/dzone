
#import "BrowserViewController.h"

@implementation BrowserViewController

@synthesize webView;
@synthesize currentItem;
@synthesize spinner;

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"web view finished loading");
	[self.spinner stopAnimating];
	[self.spinner removeFromSuperview];
}

#pragma mark -
#pragma mark UIViewController

- (void) viewWillAppear:(BOOL)animated {
	self.title = @"Browser Details";

	[self.spinner startAnimating];
	
	[self.webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:[self.currentItem valueForKey:@"deep_link"]]]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.webView = nil;
	self.currentItem = nil;
	self.spinner = nil;
}

- (void)dealloc {
	[webView release];
	[currentItem release];
	[spinner release];
	
    [super dealloc];
}

@end
