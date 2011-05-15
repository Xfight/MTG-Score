//
//  MyUIToolBar.m
//  WebViewSearching
//
//  Created by Luca on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyUIToolBar.h"


@implementation MyUIToolBar
@synthesize textField, buttonSearch, delegate;

- (void)communication
{
    [self.delegate myUIToolBar:self didPressSearchButton:textField.text];
}

- (void)pressButtonSearch:(UIBarButtonItem *)sender
{
    [self.textField resignFirstResponder];
    [self communication];
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
    [textField release];
    [buttonSearch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Return press!");
    [self communication];
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self communication];
    return NO;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textField.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.textField = nil;
    self.buttonSearch = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
