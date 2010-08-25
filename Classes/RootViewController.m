
#import "RootViewController.h"
#import "DetailViewController.h"
#import "Seriously.h"

#define DZONE_URL @"http://dzone-api.heroku.com/items.json"

@implementation RootViewController

@synthesize items;
@synthesize spinner;

#pragma mark -
#pragma mark HelperMethods

- (void)loadItems {
	items = [[NSMutableArray alloc] init];
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
	[self.view addSubview:spinner];
	[spinner startAnimating];
	
	[Seriously get:DZONE_URL handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
			NSString* errorMessage = [NSString stringWithFormat:@"Check your networking configuration, could not load %@", DZONE_URL];
			UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			[alertView release];
        }
        else {
            NSLog(@"Look, JSON is parsed into a dictionary!");
			NSLog(@"body id @%body", body);
			for (NSDictionary* dict in body) {
				[items addObject:dict];
			}
			[self.tableView reloadData];
        }
		[spinner stopAnimating];
		[spinner removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark UITableViewDelegate

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
	[self loadItems];
}

- (void)viewDidUnload {
    self.items = nil;
	self.spinner = nil;
}

- (void)dealloc {
	[items release];
	[spinner release];
	
    [super dealloc];
}

@end

