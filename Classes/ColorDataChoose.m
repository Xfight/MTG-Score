//
//  ColorDataChoose.m
//  MTG SK
//
//  Created by Luca on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ColorDataChoose.h"
#import "ColorDataEntryCell.h"


@implementation ColorDataChoose

@synthesize viewColor;
@synthesize sliderRed,sliderGreen,sliderBlue,sliderAlpha;
@synthesize colorForViewBackground, groupTableColor;
@synthesize colorDataEntryCell;


- (IBAction)cancelButton:(UIBarItem *)sender
{
	[self dismissModalViewControllerAnimated:YES];
}
- (IBAction)doneButton:(UIBarItem *)sender
{
	ColorDataEntryCell *cell = (ColorDataEntryCell *) colorDataEntryCell;
//	[cell setValueAndNotify:viewColor.backgroundColor];
	[cell setValueAndNotify:viewColor.backgroundColor groupTable:groupTableColor];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)changeColorFromButton:(UIButton *)sender
{
	switch (sender.tag) {
		case kColorRed:		viewColor.backgroundColor = [UIColor redColor]; groupTableColor = NO; break;
		case kColorGreen:	viewColor.backgroundColor = [UIColor greenColor]; groupTableColor = NO; break;
		case kColorBlack:	viewColor.backgroundColor = [UIColor blackColor]; groupTableColor = NO; break;
		case kColorBlue:	viewColor.backgroundColor = [UIColor blueColor]; groupTableColor = NO; break;
		case kColorWhite:	viewColor.backgroundColor = [UIColor whiteColor]; groupTableColor = NO; break;
		case kColorTable:	viewColor.backgroundColor = [UIColor groupTableViewBackgroundColor]; groupTableColor = YES; break;
		default:
			break;
	}
	
	UIColor *color = viewColor.backgroundColor;
	const CGFloat *components = CGColorGetComponents([color CGColor]);
	
	if ( [viewColor.backgroundColor isEqual:[UIColor blackColor]] ) {
		sliderRed.value = 0.0;
		sliderGreen.value = 0.0;
		sliderBlue.value = 0.0;
		sliderAlpha.value = 1.0;
		viewColor.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	} else if ( [viewColor.backgroundColor isEqual:[UIColor whiteColor]] ) {
		sliderRed.value = 1.0;
		sliderGreen.value = 1.0;
		sliderBlue.value = 1.0;
		sliderAlpha.value = 1.0;
		viewColor.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	} else {
		sliderRed.value = components[0];
		sliderGreen.value = components[1];
		sliderBlue.value = components[2];
		sliderAlpha.value = components[3];
	}
}

- (IBAction)changeColorFromSlider:(UISlider *)sender
{
	viewColor.backgroundColor = [UIColor
								 colorWithRed:sliderRed.value
								 green:sliderGreen.value
								 blue:sliderBlue.value
								 alpha:sliderAlpha.value/*1.0*/];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	viewColor.layer.borderColor = [[UIColor blackColor] CGColor];
	[viewColor.layer setBorderWidth: 2.0];
	viewColor.backgroundColor = colorForViewBackground;
	
	UIColor *c = viewColor.backgroundColor;
	const CGFloat *components = CGColorGetComponents([c CGColor]);
	sliderRed.value = components[0];
	sliderGreen.value = components[1];
	sliderBlue.value = components[2];
	sliderAlpha.value = components[3];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.viewColor = nil;
	
	self.sliderRed = nil;
	self.sliderGreen = nil;
	self.sliderBlue = nil;
	self.sliderAlpha = nil;
	self.colorForViewBackground = nil;
	self.colorDataEntryCell = nil;
}


- (void)dealloc {
	[viewColor release];
	
	[sliderRed release];
	[sliderGreen release];
	[sliderBlue release];
	[sliderAlpha release];
	
	[colorForViewBackground release];
	[colorDataEntryCell release];
	
    [super dealloc];
}


@end
