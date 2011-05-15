//
//  ViewFaq.m
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewFaq.h"


@implementation ViewFaq
@synthesize viewLoading, expansions;

- (void)fileRetriever:(FileRetriever *)fileRetriever didFinishRetrieve:(NSString *)content
{
    FaqAnalyzer *faqAnalyzer = [[FaqAnalyzer alloc] initWithContent:content];
    self.expansions = [NSArray arrayWithArray:[faqAnalyzer analyzeContent]];
    [faqAnalyzer release];
    
    [self.tableView reloadData];
    
    [self.viewLoading stopLoading];
    [self.viewLoading removeFromSuperview];
}

- (void)fileRetriever:(FileRetriever *)fileRetriever didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Error", @"Simple error")
                          message:NSLocalizedString(@"No connection available!", @"File Retriever miss connection")
                          delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"Simple ok")
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self.viewLoading stopLoading];
    [self.viewLoading removeFromSuperview];
}

- (ViewLoading *)viewLoading
{
    if ( ! viewLoading )
        viewLoading = [[ViewLoading alloc] initWithFrame:self.navigationController.view.frame andCenterPoint:self.navigationController.view.center];
    
    return viewLoading;
}

- (void)loadDoc
{
    [self.navigationController.view addSubview:self.viewLoading];
    [self.viewLoading startLoading];
    
    NSURL *url = [NSURL URLWithString:@"http://www.wizards.com/magic/tcg/article.aspx?x=magic/rules/faqs"];
    
    FileRetriever *f = [[FileRetriever alloc] initWithURL:url];
    f.delegate = self;
    [f startRetrieveFile];
    [f autorelease];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Faq", @"Title Frequently Asked Questions");
    
    if ( self.expansions == nil )
        self.expansions = [NSArray array];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadDoc)];
    
    //tab.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    //tab.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 44, 0);
    
    //[self pushViewController:tab animated:NO];
    
    //[self.view addSubview:viewLoading];
    //[self.view insertSubview:viewLoading atIndex:2];
    
    [self loadDoc];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

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
    return [expansions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Expansion *e = [expansions objectAtIndex:indexPath.row];
    cell.textLabel.text = e.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.viewLoading = nil;
    self.expansions = nil;
}

- (void)dealloc
{
    [viewLoading release];
    [expansions release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    
    ViewFaqDetails *vfq = [[ViewFaqDetails alloc] init];
    vfq.expansion = (Expansion *) [expansions objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vfq animated:YES];
    [vfq release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
