//
//  ViewGameLineStatus.m
//  MTG Score
//
//  Created by Luca Bertani on 24/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewGameLineStatus.h"


@implementation ViewGameLineStatus
@synthesize gameSingle, gameHistory, webView;

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

- (void)loadContent:(NSString *)tableCss withMaxSize:(float)maxSize
{ 
    NSMutableString *html = [NSMutableString string];
    //player1Name = [DataAccess objectForKey:kPlayer1];
    //player2Name = [DataAccess objectForKey:kPlayer2];
    //NSString *name1 = [self sizeToFitString:player1Name withMaxSize:maxSize];
    //NSString *name2 = [self sizeToFitString:player2Name withMaxSize:maxSize];
    
    [html appendFormat:@"<html><head><title>Report</title><link type=\"text/css\" rel=\"stylesheet\" href=\"%@\" /></head><body><table cellpadding=\"0\" cellspacing=\"0\">", tableCss];
    
    [html appendFormat:@"<tr><td colspan=\"2\" class=\"br nome1\">%@</td><td colspan=\"2\" class=\"nome2\">%@</td></tr>", gameHistory.player1name, gameHistory.player2name];
    [html appendFormat:@"<tr><td class=\"vita\">%@</td><td class=\"infect br\">%@</td><td class=\"vita\">%@</td><td class=\"infect\">%@</td></tr>",
     NSLocalizedString(@"Life", @"Title for life in ViewPlayersStatus"),
     NSLocalizedString(@"Infect", @"infect token"),
     NSLocalizedString(@"Life", @"Title for life in ViewPlayersStatus"),
     NSLocalizedString(@"Infect", @"infect token")
     ];
    
    //int len = [self.arrayPlayer1 count];
    //PlayerStatus *player;
    
    NSManagedObjectContext *context = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"GameLineStatus" inManagedObjectContext:context];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"refeerToGameSingle = %@", self.gameSingle];
    request.fetchBatchSize = 20;
    
    //[NSFetchedResultsController deleteCacheWithName:@"MyGameSingle"];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    [request release];
    
    //NSMutableArray *gameLineStatusArray = [NSMutableArray array];
    
    int i = 0;
    for (GameLineStatus *gameLineStatus in items)
    {
        if ( i % 2 == 0 ) [html appendString:@"<tr class=\"even\""];
        else [html appendString:@"<tr class=\"odd\""];
        
        //player = (PlayerStatus *)[self.arrayPlayer1 objectAtIndex:i];
        [html appendFormat:@"<td class=\"br\">%d</td><td class=\"br\">%d</td>", [gameLineStatus.player1life intValue], [gameLineStatus.player1infect intValue]];
        //player = (PlayerStatus *)[self.arrayPlayer2 objectAtIndex:i];
        [html appendFormat:@"<td class=\"br\">%d</td><td>%d</td></tr>", [gameLineStatus.player2life intValue], [gameLineStatus.player2infect intValue]];
        
        i++;
    }
    
    [html appendFormat:@"<tr><td colspan=\"4\" class=\"end\">Winner is %@</td></tr>", [self whoWin:gameSingle.outcome]];
    
    /*for (int i = 0; i < len; i++ )
     {
     if ( i % 2 == 0 ) [html appendString:@"<tr class=\"even\""];
     else [html appendString:@"<tr class=\"odd\""];
     
     player = (PlayerStatus *)[self.arrayPlayer1 objectAtIndex:i];
     [html appendFormat:@"<td class=\"br\">%d</td><td class=\"br\">%d</td>", player.life, player.infect];
     player = (PlayerStatus *)[self.arrayPlayer2 objectAtIndex:i];
     [html appendFormat:@"<td class=\"br\">%d</td><td>%d</td></tr>", player.life, player.infect];
     }*/
    
    [html appendString:@"</table></body></html>"];
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:html baseURL:baseURL];
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
    [gameHistory release];
    [gameSingle release];
    [webView release];
    
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
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Story", @"Story on ViewGameLineStatus");
}

- (void)viewWillAppear:(BOOL)animated
{
    if ( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
        [self loadContent:TABLE_CSS_PORTRAIT withMaxSize:MAX_SIZE_NAME_PORTRAIT];
    else
        [self loadContent:TABLE_CSS_LANDSCAPE withMaxSize:MAX_SIZE_NAME_LANDSCAPE];
    
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
    self.gameSingle = nil;
    self.gameHistory = nil;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //NSLog(@"width %f, height %f", self.view.frame.size.width, self.view.frame.size.height);
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self loadContent:TABLE_CSS_LANDSCAPE withMaxSize:MAX_SIZE_NAME_LANDSCAPE];
    } else {
        [self loadContent:TABLE_CSS_PORTRAIT withMaxSize:MAX_SIZE_NAME_PORTRAIT];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
