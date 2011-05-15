//
//  ViewMana.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewMana.h"

@implementation ViewMana

@synthesize scrollView;

@synthesize imageManaBlack;
@synthesize imageManaBlue;
@synthesize imageManaGreen;
@synthesize imageManaRed;
@synthesize imageManaWhite;
@synthesize imageManaColorless;

@synthesize manaBlackPool;
@synthesize manaBlackPlus;
@synthesize manaBlackMinus;
@synthesize manaBluePool;
@synthesize manaBluePlus;
@synthesize manaBlueMinus;
@synthesize manaGreenPool;
@synthesize manaGreenPlus;
@synthesize manaGreenMinus;
@synthesize manaRedPool;
@synthesize manaRedPlus;
@synthesize manaRedMinus;
@synthesize manaWhitePool;
@synthesize manaWhitePlus;
@synthesize manaWhiteMinus;
@synthesize manaColorlessPool;
@synthesize manaColorlessPlus;
@synthesize manaColorlessMinus;

@synthesize textSpell, textSpellCount, textSpellCountPlus, textSpellCountMinus;

- (IBAction)myResignFirstResponder {
	
	[UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
	[UIView setAnimationDuration: 0.35];
	
	if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		self.interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		scrollView.contentSize = CGSizeMake(480, 248);
	} else {
		scrollView.contentSize = CGSizeMake(320, 411);
	}
	
	[scrollView setContentOffset:svos animated:YES];
	
	[UIView commitAnimations];
	
	
	
	[manaBlackPool resignFirstResponder];
	[manaBluePool resignFirstResponder];
	[manaGreenPool resignFirstResponder];
	[manaRedPool resignFirstResponder];
	[manaWhitePool resignFirstResponder];
	[manaColorlessPool resignFirstResponder];
	[textSpell resignFirstResponder];
	[textSpellCount resignFirstResponder];
}

- (IBAction)checkInputInt:(id)sender {
	UITextField *textField1 = (UITextField *) sender;
	
	int a;
	BOOL check = [[NSScanner scannerWithString:textField1.text] scanInt:&a];
	
	if ( check ) {
		
		// 3 casi
		// 1. ho un numero
		// 2. ho numeri ed un carattere
		// 3. ho un overflow
		
		// caso 1. e 2. e 3. (grazie al confronto fra stringhe)
		if ( ! [textField1.text isEqualToString:[NSString stringWithFormat:@"%d", a]] ) {
			textField1.text = [NSString stringWithFormat:@"%d", a];
		}
		
		switch ([sender tag]) {
			case 1:
				if ( a < 0 ) {
					manaBlackInt = 0;
					textField1.text = @"0";
				} else 
					manaBlackInt = a;
				break;
			case 2:
				if ( a < 0 ) {
					manaBlueInt = 0;
					textField1.text = @"0";
				} else 
					manaBlueInt = a;
				break;
			case 3:
				if ( a < 0 ) {
					manaGreenInt = 0;
					textField1.text = @"0";
				} else 
					manaGreenInt = a;
				break;
			case 4:
				if ( a < 0 ) {
					manaRedInt = 0;
					textField1.text = @"0";
				} else 
					manaRedInt = a;
				break;
			case 5:
				if ( a < 0 ) {
					manaWhiteInt = 0;
					textField1.text = @"0";
				} else 
					manaWhiteInt = a;
				break;
			case 6:
				if ( a < 0 ) {
					manaColorlessInt = 0;
					textField1.text = @"0";
				} else 
					manaColorlessInt = a;
				break;
			default: break;
		}
		
	} else {
		// ho solo caratteri illegibili
		// se la stringa non e' vuota (cosa ammessa), ripulisco il testo
		if ( ! [textField1.text isEqualToString:@""] ) {
			textField1.text = @"";
			// ed azzero il contatore dei punti vita (temporaneamente)
		}
		
		/*
		 manaBlackInt = 0;
		 manaBlueInt = 0;
		 manaGreenInt = 0;
		 manaRedInt = 0;
		 manaWhiteInt = 0;
		 manaColorlessInt = 0;
		 */
		
		switch ([sender tag]) {
			case 1: manaBlackInt = 0; break;
			case 2: manaBlueInt = 0; break;
			case 3: manaGreenInt = 0; break;
			case 4: manaRedInt = 0; break;
			case 5: manaWhiteInt = 0; break;
			case 6: manaColorlessInt = 0; break;
			default: break;
		}
	}
}

- (void) animateTextField:(UITextField*)textField up:(BOOL)up
{
    //scrollView.contentSize = CGSizeMake(320, 590);
	
	
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:scrollView];
    pt = rc.origin;
	
	/*if ( pt.y < 100.0 ) {
		//svos = scrollView.contentOffset;
		return;
	}*/
	
	if ( pt.y > 290.0 ) {
		pt.y = 290.0;
	}
	
	//NSLog(@"pt.x : %f, pt.y : %f", pt.x, pt.y);
	
	/*if (svos.x == 0 && svos.y == 0)
		svos = scrollView.contentOffset;*/
    pt.x = 0;
	
	if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		self.interfaceOrientation == UIInterfaceOrientationLandscapeRight )
		pt.y -= 80;
	else
		pt.y -= 110;
	
	if ( pt.y < 0 )
		pt.y = 0;
	
	if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		self.interfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
		scrollView.contentSize = CGSizeMake(480, 349);
	} else {
		scrollView.contentSize = CGSizeMake(320, 591);
	}

    [scrollView setContentOffset:pt animated:YES];
	
	/*const int movementDistance = 180; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
	
    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    //self.view.frame = CGRectOffset(self.view.frame, 0, movement);
	
	[scrollView scrollRectToVisible:CGRectMake(600, 600, 100, 100) animated:YES];
	
    [UIView commitAnimations];*/
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


/*- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// la riga da problemi con spell: lo scroll va troppo in alto !
    /*[scrollView setContentOffset:svos animated:YES];*/
    [textField resignFirstResponder];
    return YES;
}

- (void)resetAllMana {
	manaBlackPool.text = @"0";
	manaBluePool.text = @"0";
	manaGreenPool.text = @"0";
	manaRedPool.text = @"0";
	manaWhitePool.text = @"0";
	manaColorlessPool.text = @"0";
	textSpellCount.text = @"0";
	
	manaBlackInt = 0;
	manaBlueInt = 0;
	manaGreenInt = 0;
	manaRedInt = 0;
	manaWhiteInt = 0;
	manaColorlessInt = 0;
	textSpellCountInt = 0;
}





- (IBAction)manaBlackAdd {
	if ( manaBlackInt < INT_MAX )
		manaBlackPool.text = [NSString stringWithFormat:@"%d", ++manaBlackInt];
}
- (IBAction)manaBlackRemove {
	if ( manaBlackInt > 0 )
		manaBlackPool.text = [NSString stringWithFormat:@"%d", --manaBlackInt];
}

- (IBAction)manaBlueAdd {
	if ( manaBlueInt < INT_MAX )
		manaBluePool.text = [NSString stringWithFormat:@"%d", ++manaBlueInt];
}
- (IBAction)manaBlueRemove {
	if ( manaBlueInt > 0 )
		manaBluePool.text = [NSString stringWithFormat:@"%d", --manaBlueInt];
}

- (IBAction)manaGreenAdd {
	if ( manaGreenInt < INT_MAX )
		manaGreenPool.text = [NSString stringWithFormat:@"%d", ++manaGreenInt];
}
- (IBAction)manaGreenRemove {
	if ( manaGreenInt > 0 )
		manaGreenPool.text = [NSString stringWithFormat:@"%d", --manaGreenInt];
}

- (IBAction)manaRedAdd {
	if ( manaRedInt < INT_MAX )
		manaRedPool.text = [NSString stringWithFormat:@"%d", ++manaRedInt];
}
- (IBAction)manaRedRemove {
	if ( manaRedInt > 0 )
		manaRedPool.text = [NSString stringWithFormat:@"%d", --manaRedInt];
}

- (IBAction)manaWhiteAdd {
	if ( manaWhiteInt < INT_MAX )
		manaWhitePool.text = [NSString stringWithFormat:@"%d", ++manaWhiteInt];
}
- (IBAction)manaWhiteRemove {
	if ( manaWhiteInt > 0 )
		manaWhitePool.text = [NSString stringWithFormat:@"%d", --manaWhiteInt];
}

- (IBAction)manaColorlessAdd {
	if ( manaColorlessInt < INT_MAX )
		manaColorlessPool.text = [NSString stringWithFormat:@"%d", ++manaColorlessInt];
}
- (IBAction)manaColorlessRemove {
	if ( manaColorlessInt > 0 )
		manaColorlessPool.text = [NSString stringWithFormat:@"%d", --manaColorlessInt];
}

- (IBAction)textSpellCountAdd {
	if ( textSpellCountInt < INT_MAX )
		textSpellCount.text = [NSString stringWithFormat:@"%d", ++textSpellCountInt];
}
- (IBAction)textSpellCountRemove {
	if ( textSpellCountInt > 0 )
		textSpellCount.text = [NSString stringWithFormat:@"%d", --textSpellCountInt];
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
	
    //oldInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    oldInterfaceOrientation = UIInterfaceOrientationPortrait;
    
	//scrollView.contentSize = CGSizeMake(320, 480);
	scrollView.contentSize = CGSizeMake(320, 411);
	
	manaBlackPool.delegate = self;
	manaBluePool.delegate = self;
	manaGreenPool.delegate = self;
	manaRedPool.delegate = self;
	manaWhitePool.delegate = self;
	manaColorlessPool.delegate = self;
	textSpell.delegate = self;
	textSpellCount.delegate = self;
	
	svos.x = 0.0;
	svos.y = 0.0;
	
	svos = scrollView.contentOffset;
	
	manaBlackInt = 0;
	manaBlueInt = 0;
	manaGreenInt = 0;
	manaRedInt = 0;
	manaWhiteInt = 0;
	manaColorlessInt = 0;
	textSpellCountInt = 0;
	
	self.view.backgroundColor = [DataAccess colorForKey:K_BACKGROUND_COLOR];
	
	//[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0.0f];
	
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewRotation:(BOOL)animation {
	UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
    if (animation) {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
    }
	
	if (toOrientation == UIInterfaceOrientationLandscapeLeft
		|| toOrientation == UIInterfaceOrientationLandscapeRight) {
		
		scrollView.contentSize = CGSizeMake(480, 248);
		
		imageManaBlack.frame = CGRectMake(5, 5, 50, 50);
		imageManaBlue.frame  = CGRectMake(5, 63, 50, 50);
		imageManaGreen.frame = CGRectMake(5, 121, 50, 50);
		imageManaRed.frame   = CGRectMake(237, 5, 50, 50);
		imageManaWhite.frame = CGRectMake(237, 63, 50, 50);
		imageManaColorless.frame = CGRectMake(237, 121, 50, 50);
		
		manaBlackPool.frame = CGRectMake(63,  14, 40, 31);
		manaBluePool.frame  = CGRectMake(63, 72, 40, 31);
		manaGreenPool.frame = CGRectMake(63, 130, 40, 31);
		manaRedPool.frame   = CGRectMake(295, 14, 40, 31);
		manaWhitePool.frame = CGRectMake(295, 72, 40, 31);
		manaColorlessPool.frame = CGRectMake(295, 130, 40, 31);
		
		
		manaBlackPlus.frame  = CGRectMake(114,  10, 50, 40);
		manaBlackMinus.frame = CGRectMake(172,  10, 50, 40);
		
		manaBluePlus.frame   = CGRectMake(114, 68, 50, 40);
		manaBlueMinus.frame  = CGRectMake(172, 68, 50, 40);
		
		manaGreenPlus.frame  = CGRectMake(114, 126, 50, 40);
		manaGreenMinus.frame = CGRectMake(172, 126, 50, 40);
		
		manaRedPlus.frame    = CGRectMake(346,  10, 50, 40);
		manaRedMinus.frame   = CGRectMake(404,  10, 50, 40);
		
		manaWhitePlus.frame  = CGRectMake(346, 68, 50, 40);
		manaWhiteMinus.frame = CGRectMake(404, 68, 50, 40);
		
		manaColorlessPlus.frame  = CGRectMake(346, 126, 50, 40);
		manaColorlessMinus.frame = CGRectMake(404, 126, 50, 40);
		
		textSpell.frame =           CGRectMake(100, 190, 61, 31);
		textSpellCount.frame =      CGRectMake(170, 190, 40, 31);
		textSpellCountPlus.frame =  CGRectMake(229, 186, 82, 40);
		textSpellCountMinus.frame = CGRectMake(324, 186, 82, 40);
		
	} else {
		scrollView.contentSize = CGSizeMake(320, 411);
		
		imageManaBlack.frame = CGRectMake( 14,   5, 50, 50);
		imageManaBlue.frame  = CGRectMake( 14,  63, 50, 50);
		imageManaGreen.frame = CGRectMake( 14, 121, 50, 50);
		imageManaRed.frame   = CGRectMake( 14, 179, 50, 50);
		imageManaWhite.frame = CGRectMake( 14, 237, 50, 50);
		imageManaColorless.frame = CGRectMake(14, 295, 50, 50);
		
		manaBlackPool.frame = CGRectMake(77,  14, 40, 31);
		manaBluePool.frame  = CGRectMake(77,  72, 40, 31);
		manaGreenPool.frame = CGRectMake(77, 130, 40, 31);
		manaRedPool.frame   = CGRectMake(77, 189, 40, 31);
		manaWhitePool.frame = CGRectMake(77, 246, 40, 31);
		manaColorlessPool.frame = CGRectMake(77, 304, 40, 31);
		
		manaBlackPlus.frame = CGRectMake(136,  10, 82, 40);
		manaBluePlus.frame  = CGRectMake(136,  68, 82, 40);
		manaGreenPlus.frame = CGRectMake(136, 126, 82, 40);
		manaRedPlus.frame   = CGRectMake(136, 185, 82, 40);
		manaWhitePlus.frame = CGRectMake(136, 242, 82, 40);
		manaColorlessPlus.frame = CGRectMake(136, 300, 82, 40);
		
		manaBlackMinus.frame = CGRectMake(231,  10, 82, 40);
		manaBlueMinus.frame  = CGRectMake(231,  68, 82, 40);
		manaGreenMinus.frame = CGRectMake(231, 126, 82, 40);
		manaRedMinus.frame   = CGRectMake(231, 185, 82, 40);
		manaWhiteMinus.frame = CGRectMake(231, 242, 82, 40);
		manaColorlessMinus.frame = CGRectMake(231, 300, 82, 40);
		
		textSpell.frame =           CGRectMake(  7, 357, 61, 31);
		textSpellCount.frame =      CGRectMake( 77, 357, 40, 31);
		textSpellCountPlus.frame =  CGRectMake(136, 353, 82, 40);
		textSpellCountMinus.frame = CGRectMake(231, 353, 82, 40);
	}
    
    if ( animation )
        [UIView commitAnimations];
    
    oldInterfaceOrientation = self.interfaceOrientation;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if ( [DataAccess rotationCheck:self.interfaceOrientation withOldInterfaceRotation:oldInterfaceOrientation] )
        [self viewRotation:NO];
    
    [super viewWillAppear:animated];
}

// duration : 0.3
- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[self viewRotation:YES];
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
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
	
	self.scrollView = nil;
	
	self.imageManaBlack = nil;
	self.imageManaBlue = nil;
	self.imageManaGreen = nil;
	self.imageManaRed = nil;
	self.imageManaWhite = nil;
	self.imageManaColorless = nil;
	
	self.manaBlackPool = nil;
	self.manaBlackPlus = nil;
	self.manaBlackMinus = nil;
	self.manaBluePool = nil;
	self.manaBluePlus = nil;
	self.manaBlueMinus = nil;
	self.manaGreenPool = nil;
	self.manaGreenPlus = nil;
	self.manaGreenMinus = nil;
	self.manaRedPool = nil;
	self.manaRedPlus = nil;
	self.manaRedMinus = nil;
	self.manaWhitePool = nil;
	self.manaWhitePlus = nil;
	self.manaWhiteMinus = nil;
	self.manaColorlessPool = nil;
	self.manaColorlessPlus = nil;
	self.manaColorlessMinus = nil;
	self.textSpell = nil;
	self.textSpellCount = nil;
	self.textSpellCountPlus = nil;
	self.textSpellCountMinus = nil;
}


- (void)dealloc {
	[scrollView release];
	
	[imageManaBlack release];
	[imageManaBlue release];
	[imageManaGreen release];
	[imageManaRed release];
	[imageManaWhite release];
	[imageManaColorless release];
	
	[manaBlackPool release];
	[manaBlackPlus release];
	[manaBlackMinus release];
	[manaBluePool release];
	[manaBluePlus release];
	[manaBlueMinus release];
	[manaGreenPool release];
	[manaGreenPlus release];
	[manaGreenMinus release];
	[manaRedPool release];
	[manaRedPlus release];
	[manaRedMinus release];
	[manaWhitePool release];
	[manaWhitePlus release];
	[manaWhiteMinus release];
	[manaColorlessPool release];
	[manaColorlessPlus release];
	[manaColorlessMinus release];
	[textSpell release];
	[textSpellCount release];
	[textSpellCountPlus release];
	[textSpellCountMinus release];
	
    [super dealloc];
}


@end
