
#import "BrowserViewController.h"
#import "Seriously.h"

@implementation BrowserViewController

@synthesize currentItem;
@synthesize webView;
@synthesize spinner;

#pragma mark -
#pragma mark IBAction

- (IBAction) back{
	if ([webView canGoBack]) {
		[webView goBack];
	}
}

- (IBAction) forward{
	if ([webView canGoForward]) {
		[webView goForward];
	}
}

- (IBAction) vote{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSString* user = [defaults stringForKey:@"user_preference"];
	NSString* pass = [defaults stringForKey:@"pass_preference"];
	
	if (!user || !pass) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Credentials missing!" message:@"Set your username and password in the settings application." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		return;
	}
	
	UIBarButtonItem* voteButton = [self.toolbarItems objectAtIndex:3];
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
			[currentItem setValue:@"YES" forKey:@"voted"];
        }
    }];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"web view finished loading");
	
	UIBarButtonItem* backButton = [self.toolbarItems objectAtIndex:1];
	backButton.enabled = [self.webView canGoBack];
	UIBarButtonItem* forwardButton = [self.toolbarItems objectAtIndex:2];
	forwardButton.enabled = [self.webView canGoForward];
	
	UIBarButtonItem* voteButton = [self.toolbarItems objectAtIndex:3];
	voteButton.title = @"Vote up";
	
	[self.spinner stopAnimating];
	[self.spinner removeFromSuperview];
}

#pragma mark -
#pragma mark UIViewController

- (void) viewWillAppear:(BOOL)animated {
	self.title = @"Browser Details";
	
	UIBarButtonItem* backButton = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)] autorelease];
	backButton.enabled = NO;
	UIBarButtonItem* forwardButton = [[[UIBarButtonItem alloc] initWithTitle:@"Forward" style:UIBarButtonItemStyleBordered target:self action:@selector(forward)] autorelease];
	forwardButton.enabled = NO;
	
	UIBarButtonItem* button = [[[UIBarButtonItem alloc] initWithTitle:@"Loading Page" style:UIBarButtonItemStyleBordered target:self action:@selector(vote)] autorelease];
	button.enabled = [currentItem valueForKey:@"voted"] ? NO : YES;
	UIBarButtonItem* spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	[self setToolbarItems:[NSMutableArray arrayWithObjects:spacer, backButton, forwardButton, button, spacer, nil] animated:YES];

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
