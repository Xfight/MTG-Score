//
//  TableViewConfirmInsert.m
//  MTG Score
//
//  Created by Luca on 20/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewConfirmInsert.h"


@implementation TableViewConfirmInsert
@synthesize dateStartMatch, namePlayer1, namePlayer2;
@synthesize arraySection, arrayContainer;
@synthesize delegate;

- (void)save:(int)result
{
    //[[GameKeeper sharedGameKeeper] saveGameHistory:self.dateStartMatch outcome:result player1name:textFieldNamePlayer1.text player1deck:self.textFieldDeckPlayer1.text player2name:textFieldNamePlayer2.text player2deck:textFieldDeckPlayer2.text];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString *p1n = ((EditableTableCell *)[self.tableView cellForRowAtIndexPath:indexPath]).myTextField.text;
    indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSString *p1d = ((EditableTableCell *)[self.tableView cellForRowAtIndexPath:indexPath]).myTextField.text;
    
    indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSString *p2n = ((EditableTableCell *)[self.tableView cellForRowAtIndexPath:indexPath]).myTextField.text;
    indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSString *p2d = ((EditableTableCell *)[self.tableView cellForRowAtIndexPath:indexPath]).myTextField.text;
    
    [[GameKeeper sharedGameKeeper] saveGameHistory:self.dateStartMatch outcome:result player1name:p1n player1deck:p1d player2name:p2n player2deck:p2d];
    
    [self.delegate tableViewConfirmInsertDidFinishDisplay:self resetGame:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 0 ) // win
    {
        [self save:kGameResultWin];
    }
    else if ( buttonIndex == 1 ) // lost
    {
        [self save:kGameResultLost];
    }
    else if ( buttonIndex == 2 ) // draw
    {
        [self save:kGameResultDraw];
    }
}

- (IBAction)buttonCancel:(UIBarButtonItem *)sender
{
    [self.delegate tableViewConfirmInsertDidFinishDisplay:self resetGame:NO];
}

- (IBAction)buttonSave:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:NSLocalizedString(@"Who win the match ?", @"Question winner in TableViewConfirmInsert")
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                  destructiveButtonTitle:NSLocalizedString(@"I Won", @"Winner in TableViewConfirmInsert")
                                  otherButtonTitles:NSLocalizedString(@"I Lost", @"Looser in TableViewConfirmInsert"),NSLocalizedString(@"Draw", @"Draw result"),  nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (IBAction)buttonWon
{
    [self save:kGameResultWin];
}

- (IBAction)buttonDraw
{
    [self save:kGameResultDraw];
}

- (IBAction)buttonLoose
{
    [self save:kGameResultLost];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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
    [dateStartMatch release];
    [namePlayer1 release];
    [namePlayer2 release];
    
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Result details", @"Title of TableViewConfirmInsert");
    UIBarButtonItem *b0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonCancel:)];
    self.navigationItem.leftBarButtonItem = b0;
    [b0 release];
    
    b0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonSave:)];
    self.navigationItem.rightBarButtonItem = b0;
    [b0 release];
    
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.arraySection = [NSMutableArray array];
    
    NSMutableArray *arrayPlayer1 = [NSMutableArray array];
    [arrayPlayer1 addObject:[ObjectPair objectPairString1:NSLocalizedString(@"Name", @"Name") andString2:self.namePlayer1]];
    [arrayPlayer1 addObject:[ObjectPair objectPairString1:NSLocalizedString(@"Deck", @"Deck") andString2:@""]];
    [self.arraySection addObject:NSLocalizedString(@"Player information", @"Player information")];
    
    NSMutableArray *arrayPlayer2 = [NSMutableArray array];
    [arrayPlayer2 addObject:[ObjectPair objectPairString1:NSLocalizedString(@"Name", @"Name") andString2:self.namePlayer2]];
    [arrayPlayer2 addObject:[ObjectPair objectPairString1:NSLocalizedString(@"Deck", @"Deck") andString2:@""]];
    [self.arraySection addObject:NSLocalizedString(@"Opponent information", @"Opponent information")];
    
    self.arrayContainer = [NSArray arrayWithObjects:arrayPlayer1, arrayPlayer2, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dateStartMatch = nil;
    self.namePlayer1 = nil;
    self.namePlayer2 = nil;
    
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
    static NSString *CellIdentifier = @"EditableTableCell";
    
    EditableTableCell *cell = (EditableTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
        
        // Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"EditableTableCell" bundle:nil];
        // Grab a pointer to the custom cell.
        cell = (EditableTableCell *)temporaryController.view;
        cell.myTextField.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // Release the temporary UIViewController.
        [temporaryController release];
    }
    
    ObjectPair *op = [[self.arrayContainer objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.myLabel.text = op.string1;
    cell.myTextField.text = op.string2;
	
    return cell;
}

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
}

@end
