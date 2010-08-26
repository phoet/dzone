
#import "BrowserViewController.h"
#import "Seriously.h"

@implementation BrowserViewController

@synthesize currentItem;
@synthesize webView;
@synthesize spinner;

#pragma mark -
#pragma mark IBAction

- (IBAction) vote{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSString* user = [defaults stringForKey:@"user_preference"];
	NSString* pass = [defaults stringForKey:@"pass_preference"];
	
	
	UIBarButtonItem* voteButton = [self.toolbarItems objectAtIndex:1];
	voteButton.enabled = NO;
	
	NSString* item_id = [currentItem valueForKey:@"id"];
	NSString* urlString = [NSString stringWithFormat:@"http://dzone-api.heroku.com/items/%@/vote/%@/%@", item_id, user, pass, nil];
	NSLog(@"url %@", urlString, nil);
	
	[Seriously get:urlString handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:@"Check your networking configuration, could add vote!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			[alertView release];
        }
        else {
			NSLog(@"body id %@", body);
			voteButton.title = @"Done";
        }
    }];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"web view finished loading");
	
	UIBarButtonItem* button = [[[UIBarButtonItem alloc] initWithTitle:@"Vote up" style:UIBarButtonItemStyleBordered target:self action:@selector(vote)] autorelease];
	UIBarButtonItem* spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	[self setToolbarItems:[NSMutableArray arrayWithObjects:spacer, button, spacer, nil]];
	
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
