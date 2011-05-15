//
//  ViewDiceRoll.m
//  MTG SK
//
//  Created by Luca on 21/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewDiceRoll.h"


@implementation ViewDiceRoll

@synthesize dice1Roll;
@synthesize dice1RollLabel;
@synthesize dice2Roll;
@synthesize dice2RollLabel;


- (IBAction)cancelButton {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButton {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)rollDice1 {
	int r = arc4random() % 20 + 1;
	self.dice1RollLabel.text = [NSString stringWithFormat:@"%d", r];
}

- (IBAction)rollDice2 {
	int r = arc4random() % 20 + 1;
	self.dice2RollLabel.text = [NSString stringWithFormat:@"%d", r];
}

- (IBAction)resetDice {
	self.dice1RollLabel.text = [NSString stringWithFormat:@""];
	self.dice2RollLabel.text = [NSString stringWithFormat:@""];
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
	
	dice1RollLabel.layer.borderColor = [UIColor blackColor].CGColor;
	dice1RollLabel.layer.borderWidth = 1.0;
	dice1RollLabel.layer.cornerRadius = 8;
	dice1RollLabel.backgroundColor = [UIColor whiteColor];

	dice2RollLabel.layer.borderColor = [UIColor blackColor].CGColor;
	dice2RollLabel.layer.borderWidth = 1.0;
	dice2RollLabel.layer.cornerRadius = 8;
	dice2RollLabel.backgroundColor = [UIColor whiteColor];
	
    [super viewDidLoad];
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
	
	self.dice1Roll = nil;
	self.dice1RollLabel = nil;
	self.dice2Roll = nil;
	self.dice2RollLabel = nil;
}


- (void)dealloc {
	
	[dice1Roll release];
	[dice1RollLabel release];
	[dice2Roll release];
	[dice2RollLabel release];
	
    [super dealloc];
}


@end
