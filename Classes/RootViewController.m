
#import "RootViewController.h"
#import "DetailViewController.h"
#import "Seriously.h"

//#define DZONE_URL @"http://dzone-api.heroku.com/items.json"
#define DZONE_URL @"http://localhost:3000/items.json"
#define NEXT_ITEMS 25
#define START_ITEMS 50
#define MAX_ITEMS 500

@implementation RootViewController

@synthesize items;
@synthesize spinner;
@synthesize limit;

#pragma mark -
#pragma mark HelperMethods

- (BOOL)containsItem:(NSDictionary*) item{
	for (NSDictionary* dict in self.items) {
		if ([[dict valueForKey:@"id"] isEqualToNumber:[item valueForKey:@"id"]]) {
			return YES;
		}
	}
	return NO;
}

- (void)loadItems {
	if (spinner != nil) {
		NSLog(@"Spinner is still active, skipping reload.");
		return;
	}

	self.limit = [NSNumber numberWithInt: (self.limit == nil ? START_ITEMS : NEXT_ITEMS + [self.limit intValue]) ];
	
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
	[self.view addSubview:spinner];
	[spinner startAnimating];
	
	items = items ? items : [[NSMutableArray alloc] init];
	
	NSString* url = [NSString stringWithFormat:@"%@?limit=%@", DZONE_URL, self.limit];
	[Seriously get:url handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
			NSString* errorMessage = [NSString stringWithFormat:@"Check your networking configuration, could not load %@", url];
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			[alertView release];
        }
        else {
            NSLog(@"Look, JSON is parsed into a dictionary!");
			NSLog(@"body id @%body", body);
			for (NSDictionary* dict in body) {
				if (![self containsItem:dict]) {
					[items addObject:dict];
				}
			}
			[self.tableView reloadData];
        }
		[spinner stopAnimating];
		[spinner removeFromSuperview];
		[spinner release];
		spinner = nil;
    }];
}

#pragma mark -
#pragma mark IBAction

- (IBAction) doReload{
	[self loadItems];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	if ([items count] == 0) {
		cell.textLabel.text = @"loading";
	} else {
		NSDictionary* item = [items objectAtIndex: [indexPath row]];
		cell.textLabel.font = [UIFont systemFontOfSize:12];
		cell.textLabel.text = [item valueForKey:@"title"];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
		cell.detailTextLabel.text = [item valueForKey:@"description"];
	}
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"scrolling past %@", indexPath);
	if (items && indexPath.row + 1 == [items count] && [self.limit intValue] < MAX_ITEMS) {
		NSLog(@"reaching end, loading more items");
		[self loadItems];
	}
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)showDetails:(NSIndexPath *)indexPath {
	DetailViewController* detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];
	NSUInteger row = [indexPath row];
	NSDictionary* item = [items objectAtIndex:row];
	detailViewController.currentItem = item;

	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self showDetails: indexPath];
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self showDetails: indexPath];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Latest Items";

	UIBarButtonItem* button = [[[UIBarButtonItem alloc] initWithTitle:@"Reload Items" style:UIBarButtonItemStyleBordered target:self action:@selector(doReload)] autorelease];
	UIBarButtonItem* spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	[self setToolbarItems:[NSMutableArray arrayWithObjects:spacer, button, spacer, nil] animated:YES];
	
	[self loadItems];
}

- (void)viewDidUnload {
    self.items = nil;
	self.spinner = nil;
	self.limit = nil;
}

#pragma mark -
#pragma mark LiveCycle

- (void)dealloc {
	[items release];
	[spinner release];
	[limit release];
	
    [super dealloc];
}

@end

