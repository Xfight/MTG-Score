//
//  ViewGameHistoryDetails.m
//  MTG Score
//
//  Created by Luca Bertani on 20/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewGameHistoryDetails.h"


@implementation ViewGameHistoryDetails
@synthesize gameHistory, dateFormat, arraySection, arrayContainer;

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

- (NSString *)dateFormatted:(NSDate *)date
{
    return [self.dateFormat stringFromDate:date];
}

- (NSString *)stringFromNSNumber:(NSNumber *)ns
{
    return [NSString stringWithFormat:@"%d", [ns intValue]];
}

- (NSString *)whoWin:(NSNumber *)ns
{
    int outcome = [ns intValue];
    NSString *s = nil;
    
    if ( outcome == kGameResultWin )
        s = gameHistory.player1name;
    else if ( outcome == kGameResultLost )
        s = gameHistory.player2name;
    else
        s = NSLocalizedString(@"Draw", @"Draw result");
    
    return s;
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




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case kTagWinner:
            textField.text = [self whoWin:gameHistory.outcome];
            break;
        case kTagPlayerName:
            gameHistory.player1name = textField.text;
            break;
        case kTagPlayerDeck:
            gameHistory.player1deck = textField.text;
            break;
        case kTagOpponentName:
            gameHistory.player2name = textField.text;
            break;
        case kTagOpponentDeck:
            gameHistory.player2deck = textField.text;
            break;
            
        default:
            break;
    }
    
    [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
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
    [gameHistory release];
    [dateFormat release];
    [arrayContainer release];
    [arraySection release];
    
    [cellDefault release];
    [cellDefaultClickable release];
    [cellEditable release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"History details", @"Title of ViewGameHistoryDetails");
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    int c = 10;
    cellDefault = @"UITableViewCell";
    cellEditable = @"EditableTableCell";
    cellDefaultClickable = @"DefaultTableCellClickable";
    
    self.arraySection = [NSMutableArray array];
    
    NSManagedObjectContext *context = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"GameSingle" inManagedObjectContext:context];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"whoHistory = %@", self.gameHistory];
    request.fetchBatchSize = 20;
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    [request release];
    
    NSMutableArray *gameSingleArray = [NSMutableArray array];
    
    for (GameSingle *gameSingle in items) {        
        [gameSingleArray addObject:[ObjectTableCell
                              objectTableCell:[self dateFormatted:gameSingle.timestamp]
                              andText:[NSString stringWithFormat:@"Game %d, %@", [gameSingle.numberGame intValue], [self outcomeFromNumber:gameSingle.outcome]]
                              andObj:gameSingle
                              andTag:c++
                              andReuseIdentifier:cellDefaultClickable
                              andTableCellType:cellDefaultClickable]
         ];
    }
    [self.arraySection addObject:NSLocalizedString(@"Game information", @"Game info on ViewGameHistoryDetails")];
    
    
    NSMutableArray *matchInfo = [NSMutableArray array];
    [matchInfo addObject:[ObjectTableCell
                          objectTableCell:NSLocalizedString(@"Date", @"Date on ViewGameHistoryDetails")
                          andText:[self dateFormatted:gameHistory.timestamp]
                          andObj:nil
                          andTag:c++
                          andReuseIdentifier:cellDefault
                          andTableCellType:cellDefault]
     ];
    [matchInfo addObject:[ObjectTableCell
                          objectTableCell:NSLocalizedString(@"Winner", @"Winner on ViewGameHistoryDetails")
                          andText:[self whoWin:gameHistory.outcome]
                          andObj:nil
                          andTag:kTagWinner
                          andReuseIdentifier:cellDefault
                          andTableCellType:cellEditable]
     ];
    [self.arraySection addObject:NSLocalizedString(@"Match information", @"Match info on ViewGameHistoryDetails")];
    
    NSMutableArray *playerInfo = [NSMutableArray array];
    [playerInfo addObject:[ObjectTableCell
                          objectTableCell:NSLocalizedString(@"Name", @"Name")
                          andText:gameHistory.player1name
                          andObj:nil
                          andTag:kTagPlayerName
                          andReuseIdentifier:cellEditable
                          andTableCellType:cellEditable]
     ];
    [playerInfo addObject:[ObjectTableCell
                          objectTableCell:NSLocalizedString(@"Deck", @"Deck")
                          andText:gameHistory.player1deck
                          andObj:nil
                          andTag:kTagPlayerDeck
                          andReuseIdentifier:cellEditable
                          andTableCellType:cellEditable]
     ];
    [self.arraySection addObject:NSLocalizedString(@"Player information", @"Player information")];
    
    NSMutableArray *opponentInfo = [NSMutableArray array];
    [opponentInfo addObject:[ObjectTableCell
                           objectTableCell:NSLocalizedString(@"Name", @"Name")
                           andText:gameHistory.player2name
                           andObj:nil
                           andTag:kTagOpponentName
                           andReuseIdentifier:cellEditable
                           andTableCellType:cellEditable]
     ];
    [opponentInfo addObject:[ObjectTableCell
                           objectTableCell:NSLocalizedString(@"Deck", @"Deck")
                           andText:gameHistory.player2deck
                           andObj:nil
                           andTag:kTagOpponentDeck
                           andReuseIdentifier:cellEditable
                           andTableCellType:cellEditable]
     ];
    [self.arraySection addObject:NSLocalizedString(@"Opponent information", @"Opponent information")];
    
    self.arrayContainer = [NSArray arrayWithObjects:gameSingleArray, matchInfo, playerInfo, opponentInfo, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.gameHistory = nil;
    self.dateFormat = nil;
    self.arraySection = nil;
    self.arrayContainer = nil;
}

- (void)viewWillAppear:(BOOL)animated
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //return 1;
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
    ObjectTableCell *otc = [[self.arrayContainer objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell = nil;
    
    if ( [otc.tableCellType isEqualToString:cellDefault] )
    {
        cell = [tableView dequeueReusableCellWithIdentifier:otc.tableCellType];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otc.tableCellType] autorelease];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", otc.title, otc.text];
    }
    else if ( [otc.tableCellType isEqualToString:cellEditable] )
    {
        EditableTableCell *cellTmp;
        cellTmp = (EditableTableCell *) [tableView dequeueReusableCellWithIdentifier:otc.tableCellType];
        if (cellTmp == nil) {
            // Create a temporary UIViewController to instantiate the custom cell.
            UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:otc.tableCellType bundle:nil];
            // Grab a pointer to the custom cell.
            cellTmp = (EditableTableCell *)temporaryController.view;
            [cellTmp retain];
            cellTmp.myTextField.delegate = self;
            cellTmp.selectionStyle = UITableViewCellSelectionStyleNone;
            // Release the temporary UIViewController.
            [temporaryController release];
            
            [cellTmp autorelease];
        }
        
        cellTmp.myLabel.text = otc.title;
        cellTmp.myTextField.text = otc.text;
        cellTmp.myTextField.tag = otc.tag;
        cell = cellTmp;
    }
    else if ( [otc.tableCellType isEqualToString:cellDefaultClickable] )
    {
        cell = [tableView dequeueReusableCellWithIdentifier:otc.tableCellType];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otc.tableCellType] autorelease];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", otc.title, otc.text];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
     
     */
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if ( indexPath.section == 0 )
        return YES;
    else
        return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSMutableArray *gameSingleArray = [self.arrayContainer objectAtIndex:indexPath.section];
        ObjectTableCell *otc = [gameSingleArray objectAtIndex:indexPath.row];
        GameSingle *gs = otc.obj;
        
        [[[CoreDataManager sharedCoreDataManager] managedObjectContext] deleteObject:gs];
        [gameSingleArray removeObjectAtIndex:indexPath.row];
        [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    
    ObjectTableCell *otc = [[self.arrayContainer objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ( [otc.tableCellType isEqualToString:cellDefaultClickable] )
    {
        ViewGameLineStatus *vgls = [[ViewGameLineStatus alloc] init];
        vgls.gameSingle = otc.obj;
        vgls.gameHistory = self.gameHistory;
        [self.navigationController pushViewController:vgls animated:YES];
        [vgls release];
    }
}



@end
