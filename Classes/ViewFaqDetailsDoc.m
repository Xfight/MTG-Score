//
//  ViewFaqDetailsDoc.m
//  MTG Score
//
//  Created by Luca on 15/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewFaqDetailsDoc.h"


@implementation ViewFaqDetailsDoc
@synthesize pul, web, viewLoading, webViewSearch;

- (ViewLoading *)viewLoading
{
    /*if ( ! viewLoading )
        viewLoading = [[ViewLoading createCenterLoading] retain];
     */
    if ( ! viewLoading )
        viewLoading = [[ViewLoading alloc] initWithFrame:self.view.frame andCenterPoint:self.view.center];
    
    return viewLoading;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (! buttonIndex == [actionSheet cancelButtonIndex] )
    {
        [[UIApplication sharedApplication] openURL:pul.urlLink];
    }
}

- (IBAction)menuOpenInSafari:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open in Safari", @"Button for open a link to Safari from ViewFaqDetailsDoc"), nil];
    [actionSheet showInView:self.view];
    //[actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (void)menuOpenInSafari
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open in Safari", @"Button for open a link to Safari from ViewFaqDetailsDoc"), nil];
    [actionSheet showFromToolbar:self.navigationController.toolbar];
    //[actionSheet showInView:self.navigationController];
    //[actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [viewLoading stopLoading];
    [viewLoading removeFromSuperview];
    
    redirect = NO;
    
    /*NSArray *subViews = [[NSArray alloc] initWithArray:[webView subviews]];
     UIScrollView *webScroller = (UIScrollView *)[subViews objectAtIndex:0];
     [webScroller flashScrollIndicators];*/
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *s = [error description];
    NSRange r = [s rangeOfString:@"-999"];
    if ( r.length <= 0 ) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Error", @"Simple error")
                              message:NSLocalizedString(@"Unable to load document!", @"ViewFaqDetailsDoc fail to load document")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Ok", @"Simple ok")
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [self.viewLoading stopLoading];
        [self.viewLoading removeFromSuperview];
    }
}

// metodo per non permettere di navigare in giro in caso si carichi una pagina html :D
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"%@", [[request URL] relativeString]);
    
    if ( ! redirect )
        return NO;
        
    if ( [[[request URL] relativeString] isEqualToString:[pul.urlLink relativeString]])
        return YES;
    else if ( [[[request URL] relativeString] rangeOfString:@"http://www.wizards.com/"].length > 0 )
        return YES;
    else
        return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ( pul == nil )
        pul = [[PairUrlLanguage alloc] init];
    
    /*UIBarButtonItem *b0 = [[UIBarButtonItem alloc] initWithTitle:@"prova" style:UIBarButtonItemStylePlain target:nil action:nil];
    b0.enabled = NO;
    UIBarButtonItem *b1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *b2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(menuOpenInSafari)];
    
    self.toolbarItems = [NSArray arrayWithObjects:b0,b1,b2,nil];
    self.navigationController.toolbarHidden = NO;
    
    [b0 release];
    [b1 release];
    [b2 release];*/
    
    redirect = TRUE;
    
    UIBarButtonItem *b0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(menuOpenInSafari)];
    self.navigationItem.rightBarButtonItem = b0;
    [b0 release];
    
    if ( webViewSearch == nil )
        webViewSearch = [[WebViewSearch alloc] initWithWebView:web andSuperView:self];
    [webViewSearch integrateWithSystem];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.title = pul.language;
    
    [self.view addSubview:self.viewLoading];
    [self.viewLoading startLoading];
    
    web.scalesPageToFit = YES;
    [web loadRequest:[NSURLRequest requestWithURL:pul.urlLink]];
}

- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ( [web isLoading] ) {
        [web stopLoading];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    [self.navigationController.toolbar setItems:[NSArray array]];
    self.navigationItem.rightBarButtonItem = nil;
    [self.webViewSearch removeCustomization];
    //self.navigationController.toolbarHidden = YES;
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.pul = nil;
    self.web = nil;
    self.viewLoading = nil;
    self.webViewSearch = nil;
}

- (void)dealloc
{
    [pul release];
    [web release];
    [viewLoading release];
    [webViewSearch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
