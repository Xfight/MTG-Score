//
//  TimeDataChoose.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeDataChoose.h"

@implementation TimeDataChoose

@synthesize datePicker;
@synthesize navigationBar;
@synthesize timeDataEntryCell;
@synthesize timeSecond;

- (IBAction)cancelButton {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButton {
	//date = [datePicker date];
	TimeDataEntryCell *t = (TimeDataEntryCell *) timeDataEntryCell;
	NSTimeInterval ti = [datePicker countDownDuration];
	
	int s = 0;
	int m = ti / 60;
	int h = 0;
	
	//m = ti / 60;
    
    if ( m == 1 ) m = 0;
	
	while ( m >= 60 ) {
		h += 1;
		m -= 60;
	}
	
	//h = h + (ttt / 60);
	
	[t setValueAndNotify:[NSString stringWithFormat:@"%.2d:%.2d:%.2d", h, m, s]];
	
	[self dismissModalViewControllerAnimated:YES];
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
	self.title = NSLocalizedString(@"Choose time", @"Dialog for select time");
    
	
	/*datePicker = [[UIDatePicker alloc] init];
	datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
	datePicker.minuteInterval = 5;
	
	[self.view addSubview:datePicker];*/
	
    [super viewDidLoad];
	
	/*for (UIView * subview in datePicker.subviews) {
        subview.frame = datePicker.bounds;
    }*/
	
}

- (void)viewWillAppear:(BOOL)animated {
	datePicker.countDownDuration = timeSecond;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	/*if (datePicker)
	{
		//remove it
		[datePicker removeFromSuperview];
		[datePicker release];
		
		//now add it again
		datePicker = [[UIDatePicker alloc] init];
		datePicker.frame = CGRectMake(0, 43, datePicker.frame.size.width, datePicker.frame.size.height);
		datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
		datePicker.minuteInterval = 5;
		//datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth |
		//UIViewAutoresizingFlexibleTopMargin;

		[self.view addSubview: datePicker];
	}	*/
}

/*- (void) arrangeViews: (UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        datePicker.frame = CGRectMake(0, 0, 320, 216);
    }
    else {
        datePicker.frame = CGRectMake(0, 0, 480, 162);
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self arrangeViews: [UIApplication sharedApplication].statusBarOrientation];
}

- (void) willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
										  duration: (NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation: interfaceOrientation
                                            duration: duration];
    [self arrangeViews: interfaceOrientation];
}*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.datePicker = nil;
	self.navigationBar = nil;
	self.timeDataEntryCell = nil;
}


- (void)dealloc {
	[datePicker release];
	[navigationBar release];
	[timeDataEntryCell release];
    [super dealloc];
}


@end
