//
//  ViewGameHistory.m
//  MTG Score
//
//  Created by Luca Bertani on 21/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewGameHistory.h"


@implementation ViewGameHistory
@synthesize dateFormat, arraySection, arrayContainer;

- (NSDateFormatter *)dateFormat
{
    if ( dateFormat == nil )
    {
        dateFormat = [[NSDateFormatter alloc] init];
        //[dateFormat setDateFormat:@"dd/MM/yyyy hh:mma"];
        [dateFormat setDateFormat:@"dd/MM/yy HH:mm"];
        [dateFormat setLocale:[NSLocale currentLocale]];
    }
    
    return dateFormat;
}

- (NSString *)outcomeFromNumber:(NSNumber *)ns
{
    int outcome = [ns intValue];
    NSString *s = nil;
    
    if ( outcome == kGameResultWin )
        s = NSLocalizedString(@"Won", @"Won on ViewGameHistoryDetails");
    else if ( outcome == kGameResultLost )
        s = NSLocalizedString(@"Lost", @"Lost on ViewGameHistoryDetails");
    else
        s = NSLocalizedString(@"Draw", @"Draw result");
    
    return s;
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
    [dateFormat release];
    [arraySection release];
    [arrayContainer release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)toggleEditMode
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
    {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleEditMode)];
        self.navigationItem.rightBarButtonItem = button;
        [button release]; 
    }
    else
    {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)];
        self.navigationItem.rightBarButtonItem = button;
        [button release]; 
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex != [alertView cancelButtonIndex] )
    {
        NSMutableArray *gameHistoryArray;
        gameHistoryArray = [self.arrayContainer objectAtIndex:1];
        
        for (ObjectTableCell *objectTableCell in gameHistoryArray) {
            [[[CoreDataManager sharedCoreDataManager] managedObjectContext] deleteObject:objectTableCell.obj];        
        }
        
        [gameHistoryArray removeAllObjects];
        [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
        [self.tableView reloadData];
    }
}

- (void)clearAllTable
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Clear all ?", @"Clear all in ViewGameHistory") message:NSLocalizedString(@"Delete all entry ?", @"Delete all entry in ViewGameHistory") delegate:self cancelButtonTitle:NSLocalizedString(@"No", @"No, simple") otherButtonTitles:NSLocalizedString(@"Yes", @"Yes, simple"), nil];
    [alert show];
    [alert release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"History", @"Title of ViewGameHistory");
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    button = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Clear all", @"Clear all in ViewGameHistory") style:UIBarButtonItemStyleBordered target:self action:@selector(clearAllTable)];
    self.navigationItem.leftBarButtonItem = button;
    [button release];
    
    //int c = 1;
    cellDefaultClickable = @"DefaultTableCellClickable";
    self.arraySection = [NSMutableArray array];
    
    [self.arraySection addObject:NSLocalizedString(@"Current match", @"Current match on ViewGameHistory")];
    [self.arraySection addObject:NSLocalizedString(@"Previous match", @"Previous match on ViewGameHistory")];

    //self.arrayContainer = [NSArray arrayWithObjects:gameHistoryArray, nil];
    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dateFormat = nil;
    self.arrayContainer = nil;
    self.arraySection = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    int c = 1;
    NSManagedObjectContext *context = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"GameHistory" inManagedObjectContext:context];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    [request release];
    
    NSMutableArray *gameCurrentArray = [NSMutableArray arrayWithCapacity:1];
    [gameCurrentArray addObject:[ObjectTableCell
                                 objectTableCell:NSLocalizedString(@"Current game", @"Current game on ViewGameHistory")
                                 andText:@"" 
                                 andObj:nil 
                                 andTag:c++ 
                                 andReuseIdentifier:cellDefaultClickable 
                                 andTableCellType:cellDefaultClickable
                                 ]];
    
    NSMutableArray *gameHistoryArray = [NSMutableArray array];
    NSString *s;
    
    for (GameHistory *gameHistory in items) {
        s = [NSString stringWithFormat:@"%@, %@", [self.dateFormat stringFromDate:gameHistory.timestamp], [self outcomeFromNumber:gameHistory.outcome]];
        [gameHistoryArray addObject:[ObjectTableCell
                                     objectTableCell:s
                                     andText:@""
                                     andObj:gameHistory
                                     andTag:c++
                                     andReuseIdentifier:cellDefaultClickable
                                     andTableCellType:cellDefaultClickable]
         ];
    }
    
    self.arrayContainer = [NSArray arrayWithObjects:gameCurrentArray, gameHistoryArray, nil];
    [self.tableView reloadData];
    
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.arraySection count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.arrayContainer objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.arraySection objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDefaultClickable];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDefaultClickable] autorelease];
    }
    
    // Configure the cell...
    ObjectTableCell *otc = [[self.arrayContainer objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = otc.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if ( indexPath.section == 0 )
        return NO;
    else
        return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSMutableArray *gameHistoryArray = [self.arrayContainer objectAtIndex:indexPath.section];
        ObjectTableCell *otc = [gameHistoryArray objectAtIndex:indexPath.row];
        GameSingle *gs = otc.obj;
        
        [[[CoreDataManager sharedCoreDataManager] managedObjectContext] deleteObject:gs];
        [gameHistoryArray removeObjectAtIndex:indexPath.row];
        [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    if ( indexPath.section == 0 )
    {
        //ViewGameCurrent *vgc = [[ViewGameCurrent alloc] initWithStyle:UITableViewStylePlain];
        ViewGameCurrent *vgc = [[ViewGameCurrent alloc] init];
        [self.navigationController pushViewController:vgc animated:YES];
        [vgc release];
    }
    else
    {
        ViewGameHistoryDetails *vgs = [[ViewGameHistoryDetails alloc] initWithStyle:UITableViewStyleGrouped];
        ObjectTableCell *otc = [[self.arrayContainer objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        vgs.gameHistory = otc.obj;
        [self.navigationController pushViewController:vgs animated:YES];
        [vgs release];
    }
}

@end
