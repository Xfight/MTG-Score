//
//  WebViewSearch.m
//  WebViewSearching
//
//  Created by Luca on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewSearch.h"


@implementation WebViewSearch
@synthesize webView, superView, myKeyboardToolbar, buttonNext, labelDescription, minimunWordLength;

- (KeyboardToolbar *)myKeyboardToolbar
{
    if ( myKeyboardToolbar == nil )
    {
        myKeyboardToolbar = [[KeyboardToolbar alloc] initWithSuperView:self.superView.view];
        myKeyboardToolbar.delegate = self;
    }
    
    return myKeyboardToolbar;
}

- (UIBarButtonItem *)buttonNext
{
    if ( buttonNext == nil )
    {
        buttonNext = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"next result in WebViewSearch") style:UIBarButtonItemStyleBordered target:self action:@selector(nextResult:)];
    }
    
    return buttonNext;
}

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
    [self.webView stringByEvaluatingJavaScriptFromString:startSearch];
    
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
    return [result integerValue];
}

- (void)removeAllHighlights
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}

- (void)flashBar
{
    NSArray *subViews = [NSArray arrayWithArray:[webView subviews]];
    UIScrollView *webScroller = (UIScrollView *)[subViews objectAtIndex:0];
    [webScroller flashScrollIndicators];
}

- (void)startSearch:(NSString *)text
{    
    //if ( [text isEqualToString:@""] ) return;
    if ( [text length] < minimunWordLength )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",@"Simple error") message:NSLocalizedString(@"Word too short! Minimun 3 character", @"AlertView in WebViewSearch: error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok", @"Simple ok"), nil];
        [alert show];
        [alert release];
        [self removeAllHighlights];
        labelDescription.text = NSLocalizedString(@"0 of 0 results", @"Number of result with 0 result in WebViewSearch");
        return;
    }
    
    int total = [self highlightAllOccurencesOfString:text];
    if ( total > 0 )
    {
        labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"%d of %d results", @"Number of result with %d of %d result in WebViewSearch"), 1, total];
        [self flashBar];
    }
    else
    {
        labelDescription.text = NSLocalizedString(@"0 of 0 results", @"Number of result with 0 result in WebViewSearch");
    }
}

- (void)nextResult:(UIBarButtonItem *)sender
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"MyApp_PositionOnNext()"];
    
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"MyApp_PosNext"];
    int pos = [result integerValue];
    result = [self.webView stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
    int total = [result integerValue];
    
    labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"%d of %d results", @"Number of result with %d of %d result in WebViewSearch"), pos, total];
    [self flashBar];
}

- (void)keyboardToolbar:(KeyboardToolbar *)keyboardToolbar didStartSearch:(NSString *)text
{
    [self startSearch:text];
    self.myKeyboardToolbar.delegate = nil;
    self.myKeyboardToolbar = nil;
}

- (void)popupKeyboardForSearch
{   
    [self.myKeyboardToolbar displayKeyboard];
}


#pragma mark -

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    
    return self;
}

- (id)initWithWebView:(UIWebView *)aWebView andSuperView:(UIViewController *)aSuperView
{
    if ((self = [super init]))
    {
        self.webView = aWebView;
        self.superView = aSuperView;
        self.minimunWordLength = 3;
    }
    
    return self;
}

- (void)integrateWithSystem
{    
    labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 220, 20)];
    labelDescription.backgroundColor = [UIColor clearColor];
    labelDescription.textColor = [UIColor whiteColor];
    labelDescription.font = [UIFont boldSystemFontOfSize:18];
    labelDescription.textAlignment = UITextAlignmentCenter;
    labelDescription.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |  UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    labelDescription.text = @""; 
    
    UIBarButtonItem *buttonSearch = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(popupKeyboardForSearch)];
    UIBarButtonItem *b0 = [[UIBarButtonItem alloc] initWithCustomView:labelDescription];
    
    UIBarButtonItem *b1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.superView.toolbarItems = [NSArray arrayWithObjects:self.buttonNext, b0, b1, buttonSearch, nil];
    self.superView.navigationController.toolbarHidden = NO;
    
    [b0 release];
    [b1 release];
    [buttonSearch release];
}

- (void)removeCustomization
{
    self.superView.toolbarItems = [NSArray array];
    self.superView.navigationController.toolbarHidden = YES;
}

- (void)dealloc
{
    [webView release];
    [superView release];
    [myKeyboardToolbar release];
    [buttonNext release];
    [labelDescription release];
    [super dealloc];
}

@end
