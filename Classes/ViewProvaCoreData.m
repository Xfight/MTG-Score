//
//  ViewProvaCoreData.m
//  MTG Score
//
//  Created by Luca Bertani on 17/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewProvaCoreData.h"

@implementation ViewProvaCoreData
@synthesize managedObjectContext;

- (IBAction)buttonPress:(UIButton *)sender
{
    GameLineStatus *gls = [NSEntityDescription insertNewObjectForEntityForName:@"GameLineStatus" inManagedObjectContext:self.managedObjectContext];
    GameHistory *gh = [NSEntityDescription insertNewObjectForEntityForName:@"GameHistory" inManagedObjectContext:self.managedObjectContext];
    gh.gamelose = [NSNumber numberWithInt:0];
    gh.gametie = [NSNumber numberWithInt:0];
    gh.gamewin = [NSNumber numberWithInt:2];
    gh.player1deck = @"deck player 1";
    gh.player1name = @"Io";
    gh.player2deck = @"deck player 2";
    gh.player2name = @"Avversario";
    gh.timestamp = [NSDate date];
    
    
    //gls.gameHistory = gh;
    gls.player1infect = [NSNumber numberWithInt:0];
    gls.player1life = [NSNumber numberWithInt:13];
    gls.player2infect = [NSNumber numberWithInt:0];
    gls.player2life = [NSNumber numberWithInt:0];
    
    [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
}

- (IBAction)buttonOpenView:(UIButton *)sender
{
    ViewTable *vt = [[ViewTable alloc] initInManagedObjectContext:self.managedObjectContext];
    [self.navigationController pushViewController:vt animated:YES];
    [vt release];
}

- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    
    for (NSManagedObject *managedObject in items) {
        [self.managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    
}

- (IBAction)buttonClean:(UIButton *)sender
{
    [self deleteAllObjects:@"GameHistory"];
    [self deleteAllObjects:@"GameSingle"];
    [self deleteAllObjects:@"GameLineStatus"];
}


- (NSManagedObjectContext *)managedObjectContext
{
    if ( managedObjectContext == nil )
        managedObjectContext = [[[CoreDataManager sharedCoreDataManager] managedObjectContext] retain];
    
    return managedObjectContext;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    if ((self = [super init]))
    {
        //self.managedObjectContext = context;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [managedObjectContext release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    //self.managedObjectContext = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.managedObjectContext = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
