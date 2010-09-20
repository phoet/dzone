
#import "DetailViewController.h"
#import "Seriously.h"
#import "BrowserViewController.h"

@implementation DetailViewController

@synthesize currentItem;
@synthesize description;
@synthesize itemTitle, categories, scores, clicks, comments;
@synthesize thumbnail;
@synthesize spinner;

#pragma mark -
#pragma mark IBAction

- (IBAction) showInSafari:(id) sender{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: [self.currentItem valueForKey:@"deep_link"]]];
}

- (IBAction) showInBrowser:(id) sender{
	BrowserViewController* browserViewController = [[BrowserViewController alloc] initWithNibName:@"BrowserViewController" bundle:nil];
	browserViewController.currentItem = self.currentItem;
	[self.navigationController pushViewController:browserViewController animated:YES];
	[browserViewController release];
}

#pragma mark -
#pragma mark UIViewController

- (void) viewWillAppear:(BOOL)animated {
	self.title = @"Item Details";

	UIBarButtonItem* openInBrowserButton = [[[UIBarButtonItem alloc] initWithTitle:@"Open in Browser" style:UIBarButtonItemStyleBordered target:self action:@selector(showInBrowser:)] autorelease];
	UIBarButtonItem* openInSafariButton = [[[UIBarButtonItem alloc] initWithTitle:@"Open in Safari" style:UIBarButtonItemStyleBordered target:self action:@selector(showInSafari:)] autorelease];
	UIBarButtonItem* spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	[self setToolbarItems:[NSMutableArray arrayWithObjects:spacer, openInBrowserButton, openInSafariButton, spacer, nil] animated:YES];
	
	itemTitle.text = [currentItem valueForKey:@"title"];
	categories.text = [currentItem valueForKey:@"categories"];
	
	description.text = [currentItem valueForKey:@"description"];
	
	clicks.text = [[[currentItem valueForKey:@"clicks"] stringValue] stringByAppendingString:@" clicks"];
	scores.text = [[[currentItem valueForKey:@"vote_up"] stringValue] stringByAppendingString:@" vote-ups"];
	comments.text = [[[currentItem valueForKey:@"comments"] stringValue] stringByAppendingString:@" comments"];
	
	[spinner startAnimating];
	
	[Seriously get:[currentItem valueForKey:@"thumbnail"] handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
			NSString* errorMessage = [NSString stringWithFormat:@"Check your networking configuration, could not load image from %@", [currentItem valueForKey:@"thumbnail"]];
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			[alertView release];
        }
        else {
            NSLog(@"image loaded from %@!", [currentItem valueForKey:@"thumbnail"]);
			[spinner stopAnimating];
			[spinner removeFromSuperview];
			thumbnail.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: [currentItem valueForKey:@"thumbnail"]]]];
        }
    }];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
	self.currentItem = nil;
	self.description = nil;
	self.itemTitle = nil;
	self.categories = nil;
	self.scores = nil;
	self.clicks = nil;
	self.comments = nil;
	self.thumbnail = nil;
	self.spinner = nil;
}

- (void)dealloc {
	[currentItem release];
	[description release];
	[itemTitle release]; 
	[categories release];
	[scores release]; 
	[clicks release]; 
	[comments release];
	[thumbnail release];
	[spinner release];
	
    [super dealloc];
}

@end
