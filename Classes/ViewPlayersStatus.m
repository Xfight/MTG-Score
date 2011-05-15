//
//  ViewPlayersStatus.m
//  MTG Score
//
//  Created by Luca on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewPlayersStatus.h"


@implementation ViewPlayersStatus
@synthesize arrayPlayer1, player1Name, arrayPlayer2, player2Name;
@synthesize webView;

- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
	[self dismissModalViewControllerAnimated:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#define MAX_SIZE_NAME_PORTRAIT  134.0
#define MAX_SIZE_NAME_LANDSCAPE 200.0
#define SIZE_3_DOT      14.0

- (NSString *)sizeToFitString:(NSString *)name withMaxSize:(float)maxSize
{
    NSString *tmp = name;
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:16];
    CGSize size = [name sizeWithFont:font];
        
    if ( size.width >= maxSize )
    {
        NSMutableString *tmp2 = [NSMutableString stringWithString:tmp];
        NSRange r;
        r.length = 1;
        while (size.width >= maxSize)
        {
            r.location = [tmp2 length] - 1;
            [tmp2 deleteCharactersInRange:r];
            
            size = [tmp2 sizeWithFont:font];
            size.width += SIZE_3_DOT;
        }
        tmp = [NSString stringWithFormat:@"%@...", tmp2];
    }
    
    return tmp;
}

#define TABLE_CSS_PORTRAIT  @"style-portrait.css"
#define TABLE_CSS_LANDSCAPE @"style-landscape.css"

- (void)loadContent:(NSString *)tableCss withMaxSize:(float)maxSize
{ 
    NSMutableString *html = [NSMutableString string];
    player1Name = [DataAccess objectForKey:kPlayer1];
    player2Name = [DataAccess objectForKey:kPlayer2];
    NSString *name1 = [self sizeToFitString:player1Name withMaxSize:maxSize];
    NSString *name2 = [self sizeToFitString:player2Name withMaxSize:maxSize];
    
    [html appendFormat:@"<html><head><title>Report</title><link type=\"text/css\" rel=\"stylesheet\" href=\"%@\" /></head><body><table cellpadding=\"0\" cellspacing=\"0\">", tableCss];
    
    [html appendFormat:@"<tr><td colspan=\"2\" class=\"br nome1\">%@</td><td colspan=\"2\" class=\"nome2\">%@</td></tr>", name1, name2];
    [html appendFormat:@"<tr><td class=\"vita\">%@</td><td class=\"infect br\">%@</td><td class=\"vita\">%@</td><td class=\"infect\">%@</td></tr>",
        NSLocalizedString(@"Life", @"Title for life in ViewPlayersStatus"),
        NSLocalizedString(@"Infect", @"infect token"),
        NSLocalizedString(@"Life", @"Title for life in ViewPlayersStatus"),
        NSLocalizedString(@"Infect", @"infect token")
     ];
    
    int len = [self.arrayPlayer1 count];
    PlayerStatus *player;
    
    for (int i = 0; i < len; i++ )
    {
        if ( i % 2 == 0 ) [html appendString:@"<tr class=\"even\""];
        else [html appendString:@"<tr class=\"odd\""];
        
        player = (PlayerStatus *)[self.arrayPlayer1 objectAtIndex:i];
        [html appendFormat:@"<td class=\"br\">%d</td><td class=\"br\">%d</td>", player.life, player.infect];
        player = (PlayerStatus *)[self.arrayPlayer2 objectAtIndex:i];
        [html appendFormat:@"<td class=\"br\">%d</td><td>%d</td></tr>", player.life, player.infect];
    }
    
    [html appendString:@"</table></body></html>"];
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [webView loadHTMLString:html baseURL:baseURL];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /* Debug load
     NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"pagina" ofType:@"html"];
     NSMutableString *html = [NSMutableString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
     */
    
        
}

- (void)viewWillAppear:(BOOL)animated
{
    if ( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
        [self loadContent:TABLE_CSS_PORTRAIT withMaxSize:MAX_SIZE_NAME_PORTRAIT];
    else
        [self loadContent:TABLE_CSS_LANDSCAPE withMaxSize:MAX_SIZE_NAME_LANDSCAPE];

    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self loadContent:TABLE_CSS_LANDSCAPE withMaxSize:MAX_SIZE_NAME_LANDSCAPE];
    } else {
        [self loadContent:TABLE_CSS_PORTRAIT withMaxSize:MAX_SIZE_NAME_PORTRAIT];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.arrayPlayer1 = nil;
    self.player1Name = nil;
    self.arrayPlayer2 = nil;
    self.player2Name = nil;
    self.webView = nil;
}

- (void)dealloc
{
    [arrayPlayer1 release];
    [player1Name release];
    [arrayPlayer2 release];
    [player2Name release];
    [webView release];
    [super dealloc];
}



@end
