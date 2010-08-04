
#import "DetailViewController.h"

@implementation DetailViewController

@synthesize titleBar, categoriesBar;
@synthesize currentItem;
@synthesize description;
@synthesize score, clicks, comments;
@synthesize thumbnail;

- (void) viewWillAppear:(BOOL)animated {
	
	self.title = @"Item Details";
	
	titleBar.topItem.title = currentItem.title;
	categoriesBar.topItem.title = [currentItem.categories componentsJoinedByString:@", "];
	
	description.text = currentItem.description;
	clicks.text = [[currentItem.clickCount stringValue] stringByAppendingString:@" clicks"];
	NSNumber* scoreNumber = [NSNumber numberWithInt:currentItem.voteUpCount - currentItem.voteDownCount];
	score.text = [[scoreNumber stringValue] stringByAppendingString:@" score"];
	comments.text = [[currentItem.commentCount stringValue] stringByAppendingString:@" comments"];
	thumbnail.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: currentItem.thumbnail]]];
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
