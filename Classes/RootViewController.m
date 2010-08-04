
#import "RootViewController.h"
#import "DetailViewController.h"
#import "Seriously.h"

#define DZONE_URL @"http://dzone-api.heroku.com/items.json"

@implementation RootViewController

@synthesize items;
@synthesize spinner;

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
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Latest Items";
	[self loadItems];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}


// Customize the appearance of table view cells.
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



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)showDetails:(NSIndexPath *)indexPath {
	DetailViewController	* detailViewController = [[DetailViewController		alloc] initWithNibName:@"DetailView" bundle:nil];
	NSUInteger row = [indexPath row];
	NSDictionary* item = [items objectAtIndex:row];
	detailViewController.currentItem = item;
	// Pass the selected object to the new view controller.
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
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

