//
//  ViewCard.m
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewCard.h"
#import "ViewSearch.h"
#import "ImageLoadingOperation.h"


@implementation ViewCard

@synthesize card, myWebView, navTitle;



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //NSArray *subViews = [[NSArray alloc] initWithArray:[webView subviews]];
    NSArray *subViews = [NSArray arrayWithArray:[webView subviews]];
    UIScrollView *webScroller = (UIScrollView *)[subViews objectAtIndex:0];
    [webScroller flashScrollIndicators];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *s = [error description];
    NSRange r = [s rangeOfString:@"-999"];
    if ( r.length <= 0 ) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)endWebViewLoad
{
    if ( [myWebView isLoading] )
        [myWebView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)loadContent:(int)imagePad
{
    self.title = card.name;
    //self.navTitle.title = card.name;
    
    NSMutableString *htmlToLoad = [NSMutableString string];
    
    [htmlToLoad appendString:@"<html><head><title>Card</title></head>"];
    [htmlToLoad appendString:@"<body style=\"margin:0; padding:0\">"];
    [htmlToLoad appendFormat:@"<img width=\"270\" height=\"385\" src=\"%@\" style=\"padding-left: %dpx\" /><br />", card.image, imagePad];
    
    [htmlToLoad appendString:@"<div style=\"padding: 6px 0 4px 6px; font-weight:bold; font-size:20px\">Faqs</div>"];
    [htmlToLoad appendString:@"<ul style=\"margin:0; padding:0 4px 0 25px\">"];
    NSMutableArray *arrayFaq = card.faqs;
    for (int i = 0; i < [arrayFaq count]; i++) {
        [htmlToLoad appendFormat:@"<li style=\"padding-left: -6px\">%@</li>", [arrayFaq objectAtIndex:i]];
	}
    [htmlToLoad appendString:@"</ul><br />"];
    
    [htmlToLoad appendString:@"<div style=\"padding: 6px 0 4px 6px; font-weight:bold; font-size:20px\">Legals</div>"];
    [htmlToLoad appendString:@"<ul style=\"margin:0; padding:0 4px 0 25px\">"];
    arrayFaq = card.legals;
    for (int i = 0; i < [arrayFaq count]; i++) {
        [htmlToLoad appendFormat:@"<li style=\"padding-left: -6px\">%@</li>", [arrayFaq objectAtIndex:i]];
	}
    [htmlToLoad appendString:@"</ul><br />"];
    
    [htmlToLoad appendString:@"</body></html>"];
    
    //NSURL *url = [NSURL URLWithString:@"http://magiccards.info/"];
    NSURL *url = [NSURL URLWithString:@"file://"];
    
    myWebView.delegate = self;
    myWebView.scalesPageToFit = NO;
    [myWebView loadHTMLString:htmlToLoad baseURL:url];
    //[myWebView loadHTMLString:htmlToLoad baseURL:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if ( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
        [self loadContent:imagePadPortrait];
    else
        [self loadContent:imagePadLandscape];
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self endWebViewLoad];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self loadContent:imagePadLandscape];
    } else {
        [self loadContent:imagePadPortrait];
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
	self.card = nil;
    self.myWebView = nil;
	self.navTitle = nil;
}


- (void)dealloc {
	[card release];
    [myWebView release];
    [navTitle release];
    [super dealloc];
}


@end
