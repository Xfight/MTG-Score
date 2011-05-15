//
//  ViewSearch.m
//  MTG SK
//
//  Created by Luca on 21/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewSearch.h"

@implementation ViewSearch
@synthesize tableData;
@synthesize results;
@synthesize xml;
@synthesize prevCard;

@synthesize theSearchBar;
@synthesize theTableView;
@synthesize disableViewOverlay;
@synthesize viewLoading;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*- (ViewLoading *)viewLoading
{
    if ( ! viewLoading )
    {
        //viewLoading = [[ViewLoading alloc] initWithFrame:self.view.bounds];
        //viewLoading = [[ViewLoading createCenterLoading] retain];
        //viewLoading = [[ViewLoading alloc] initWithFrame:self.navigationController.view.frame andCenterPoint:self.navigationController.view.center];
        viewLoading = [[ViewLoading alloc] initWithFrame:self.view.frame andCenterPoint:self.view.center];
    }
    
    return viewLoading;
}
*/

#pragma mark -
#pragma mark View's Life Cycle

- (id)init {
	if ( (self = [super init]) ) {
		self.disableViewOverlay = [[[UIView alloc]
								   initWithFrame:CGRectMake(0.0f,44.0f,320.0f,416.0f)] autorelease];
		self.disableViewOverlay.backgroundColor=[UIColor blackColor];
		self.disableViewOverlay.alpha = 0;
		self.disableViewOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | 
		UIViewAutoresizingFlexibleHeight;
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    self.tableData =[NSMutableArray array];
	
	UITapGestureRecognizer *tapRecon = [[UITapGestureRecognizer alloc]
										initWithTarget:self action:@selector(tapDisableViewOverlay:)];
    tapRecon.numberOfTapsRequired = 1;
	[self.disableViewOverlay addGestureRecognizer:tapRecon];
	[tapRecon release];
	
    if ( ! viewLoading )
        viewLoading = [[ViewLoading alloc] initWithFrame:self.view.frame andCenterPoint:self.view.center];
    
    [self.view addSubview:self.viewLoading];
	self.title = NSLocalizedString(@"Card's search", @"Title for ViewSearch");
    [self.theSearchBar setShowsCancelButton:NO animated:NO];
    
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
		|| interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		
		self.disableViewOverlay.frame = CGRectMake(0.0f,44.0f,480.0f,256.0f);
	} else {
		self.disableViewOverlay.frame = CGRectMake(0.0f,44.0f,320.0f,416.0f);
	}
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController.view addSubview:self.viewLoading];
    //[self.view addSubview:self.viewLoading];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.viewLoading removeFromSuperview];
}*/

- (void)tapDisableViewOverlay:(UIGestureRecognizer *)recognizer {
	[self searchBar:theSearchBar activate:NO];
	[disableViewOverlay removeFromSuperview];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {	
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
		|| interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		
		self.disableViewOverlay.frame = CGRectMake(0.0f,44.0f,480.0f,256.0f);
	} else {
		self.disableViewOverlay.frame = CGRectMake(0.0f,44.0f,320.0f,416.0f);
	}
	//480.000000, height : 256.000000, x : 0.000000, y : 44.000000
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self searchBar:searchBar activate:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=@"";
    [self searchBar:searchBar activate:NO];
	[disableViewOverlay removeFromSuperview];
}

#pragma mark -
#pragma mark XMLParserDelegate

- (void)xmlParser:(XMLParser *)xmlParser didFinishWithResult:(NSMutableArray *)cards
{
    [self searchBar:theSearchBar activate:NO];
    self.results = cards;
	
	if ( [self.results count] > 0 ) {
		Card *c = (Card *) [self.results objectAtIndex:[self.results count]-1 ];
		if ( c.succ ) {
			c.name = NSLocalizedString(@"Next 20 cards", @"Next 20 cards in ViewSearch");
		}
	}
	
    [self.tableData removeAllObjects];
	
	if ( self.prevCard ) {
		[self.tableData addObject:self.prevCard];
	}
	
    [self.viewLoading stopLoading];
	//[self.viewLoading removeFromSuperview];
	
	[self.tableData addObjectsFromArray:self.results];
	[self.theTableView setContentOffset:CGPointMake(0, 0) animated:NO]; 
    [self.theTableView reloadData];
    
    if ( xml ) 
    {
        xml.delegate = nil;
        [xml release];
        xml = nil;
    }
}

- (void)xmlParser:(XMLParser *)xmlParser didFailWithError:(NSError *)error
{
    if ( xml )
    {
        xml.delegate = nil;
        [xml release];
        xml = nil;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Simple error") message:NSLocalizedString(@"Unable to retrieve cards", @"Error text message from uialertview in ViewSearch") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Simple ok") otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self.viewLoading stopLoading];
	//[self.viewLoading removeFromSuperview];
}

#pragma mark -
#pragma mark Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // SomeService is just a dummy class representing some 
    // api that you are using to do the search
	
	[searchBar resignFirstResponder];
	[disableViewOverlay removeFromSuperview];
	
	if ( self.prevCard ) {
		//[prevCard release];
		self.prevCard = nil;
	}
	
    // gestita da FileRetriever
	/*if ( ! [MyConnection isConnected] )
		return;*/
	
    //[self.viewLoading fixRotation];
	//[self.view addSubview:self.viewLoading];
    //[self.navigationController.view addSubview:self.viewLoading];
	[self.viewLoading startLoading];
    
    if ( xml != nil )
    {
        xml.delegate = nil;
        [xml release];
        xml = nil;
    }
	
    xml = [[XMLParser alloc] initWithString:searchBar.text];
    xml.delegate = self;
    [xml startParsing];
    
	/*XMLParser *myXml = [[XMLParser alloc] initWithString:searchBar.text];
    myXml.delegate = self;
	[myXml startParsing];*/
}

- (void)startSearchForPage:(NSString *) page {
	/*if (xml != nil) {
     xml.delegate = nil;
     [xml release];
     xml = nil;
     }*/
	
    // gestita da FileRetriever
	/*if ( ! [MyConnection isConnected] )
		return;*/
	
    //[self.viewLoading fixRotation];
	//[self.view addSubview:self.viewLoading];
	[self.viewLoading startLoading];
	
	/*xml = [[XMLParser alloc] initWithString:self.theSearchBar.text];
     xml.delegate = self;
     [xml startParsingWithPage:page];*/
    
    /*XMLParser *myXml = [[[XMLParser alloc] initWithString:self.theSearchBar.text] autorelease];
     myXml.delegate = self;
     [myXml startParsingWithPage:page];*/
    
    if ( xml != nil )
    {
        xml.delegate = nil;
        [xml release];
        xml = nil;
    }
	
    xml = [[XMLParser alloc] initWithString:self.theSearchBar.text andPage:page];
    xml.delegate = self;
    [xml startParsing];
}

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{	
    self.theTableView.allowsSelection = !active;
    self.theTableView.scrollEnabled = !active;
    if (!active) {
        //[disableViewOverlay removeFromSuperview];
        [searchBar resignFirstResponder];
    } else {
        self.disableViewOverlay.alpha = 0;
        [self.view addSubview:self.disableViewOverlay];
		
        [UIView beginAnimations:@"FadeIn" context:nil];
        [UIView setAnimationDuration:0.3];
        self.disableViewOverlay.alpha = 0.6;
        [UIView commitAnimations];
		
        // probably not needed if you have a details view since you 
        // will go there on selection
        NSIndexPath *selected = [self.theTableView 
								 indexPathForSelectedRow];
        if (selected) {
            [self.theTableView deselectRowAtIndexPath:selected 
											 animated:NO];
        }
    }
    [searchBar setShowsCancelButton:active animated:YES];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"SearchResult";
    UITableViewCell *cell = [tableView
							 dequeueReusableCellWithIdentifier:MyIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault 
				 reuseIdentifier:MyIdentifier] autorelease];
    }
	
	Card *c = [self.tableData objectAtIndex:indexPath.row];
	cell.textLabel.text = c.name;
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Card *c = (Card *) [tableData objectAtIndex:indexPath.row];
	
	if ( c.succ || c.prev ) {
		
		if ( self.prevCard ) {
			//[self.prevCard release];
			self.prevCard = nil;
		}
			
		self.prevCard = [[[Card alloc] init] autorelease];
		
		if ( c.succ ) {
			self.prevCard.prev = [NSString stringWithFormat:@"%d", [c.succ intValue] - 1];
			self.prevCard.name = NSLocalizedString(@"Prev 20 cards", @"Previos 20 cards in ViewSearch");
		} else {
			if ( [c.prev isEqualToString:@"1" ] ) {
				
				//[self.prevCard release];
				self.prevCard = nil;
				
			} else {
				self.prevCard.prev = [NSString stringWithFormat:@"%d", [c.prev intValue] - 1];
				self.prevCard.name = NSLocalizedString(@"Prev 20 cards", @"Previos 20 cards in ViewSearch");
			}
		}
        
        NSString *s;
        if ( c.succ )
            s = c.succ;
        else
            s = c.prev;
		
		//[self searchSelectedPage:(c.succ ? c.succ : c.prev)];
        //[self searchSelectedPage:s];
        [self startSearchForPage:s];
		
	} else {
		ViewCard *vc = [[ViewCard alloc] init];
		vc.card = (Card *) [tableData objectAtIndex:indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
		//[self presentModalViewController:vc animated:YES];
		[vc release];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}


#pragma mark -
#pragma mark Memory Management Methods

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.tableData = nil;
	self.results = nil;
	self.disableViewOverlay = nil;
	self.xml = nil;
	self.prevCard = nil;
	
	self.theTableView = nil;
	self.theSearchBar = nil;
	self.viewLoading = nil;
}

- (void)dealloc {
    [tableData release];
	[results release];
	[disableViewOverlay release];
	[xml release];
	/*if ( prevCard ) {
		[prevCard release];
	}*/
    [prevCard release];
	
	[theTableView release];
    [theSearchBar release];
	/*if ( viewLoading ) {
		[viewLoading release];
	}*/
    [viewLoading release];
		
    [super dealloc];
}


@end
