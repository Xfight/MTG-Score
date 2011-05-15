//
//  ViewAllSearch.m
//  MTG Score
//
//  Created by Luca on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewAllSearch.h"

@interface ViewAllSearch()
@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) ViewFaq *viewFaq;
@property (nonatomic, retain) ViewSearch *viewSearch;
@end

@implementation ViewAllSearch
@synthesize tableData, viewFaq, viewSearch;

- (ViewFaq *)viewFaq
{
    if ( viewFaq == nil )
        viewFaq = [[ViewFaq alloc] init];
    return viewFaq;
}

- (ViewSearch *)viewSearch
{
    if ( viewSearch == nil )
        viewSearch = [[ViewSearch alloc] init];
    return viewSearch;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tableData release];
    [viewFaq release];
    [viewSearch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Search", @"Title for ViewAllSearch on top bar");
    
    /*ViewFaq *viewFaq = [[ViewFaq alloc] init];
    ViewSearch *viewSearch = [[ViewSearch alloc] init];*/
    
    self.tableData = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Search a card", @"Title for cell in TableAllSearch that represent ViewSearh"),
                      NSLocalizedString(@"View faq for expansions", @"View a faq's doc for an expansion with ViewFaq"),
                      nil];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableData = nil;
    self.viewFaq = nil;
    self.viewSearch = nil;
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    /*if ( indexPath.row == 0 )
    {
        cell.textLabel.text = NSLocalizedString(@"Search a card", @"Title for cell in TableAllSearch that represent ViewSearh");
    } else if ( indexPath.row == 1 )
    {
        cell.textLabel.text = NSLocalizedString(@"View faq for expansions", @"View a faq's doc for an expansion with ViewFaq");
    }*/
    
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    UIViewController *v;
    
    // lazy loading ^^
    if ( indexPath.row == 0 )
        v = self.viewSearch;
    else if ( indexPath.row == 1 )
        v = self.viewFaq;
    else
        v = nil;
    
    [self.navigationController pushViewController:v animated:YES];
    //[v release];
}

@end
