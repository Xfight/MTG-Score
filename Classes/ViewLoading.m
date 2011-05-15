//
//  ViewLoading.m
//  MTG SK
//
//  Created by Luca on 26/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewLoading.h"

#define WIDTH_ACTIVITY	28.0f
#define HEIGHT_ACTIVITY	28.0f
#define BOTTOM_PAD_ACTIVITY	9.0f

@implementation ViewLoading

@synthesize labelContainer, activity, labelText;

- (id)initWithFrame:(CGRect)frame andCenterPoint:(CGPoint)center
{    
    if ((self = [super initWithFrame:frame]))
    {
        self.alpha = 1.0f;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth
		| UIViewAutoresizingFlexibleHeight
		;
        
        CGRect rect = CGRectMake(0, 0, 120, 120);
        
        self.labelContainer = [[[UIView alloc] initWithFrame:rect] autorelease];
        self.labelContainer.center = center;
		self.labelContainer.backgroundColor = [UIColor blackColor];
		self.labelContainer.alpha = 0.7f;
		self.labelContainer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
		| UIViewAutoresizingFlexibleRightMargin
		| UIViewAutoresizingFlexibleTopMargin
		| UIViewAutoresizingFlexibleBottomMargin;
		[self addSubview:labelContainer];
		self.labelContainer.layer.cornerRadius = 10;
        
        float x = rect.size.width / 2 - WIDTH_ACTIVITY / 2;
		float y = rect.size.height / 2 - HEIGHT_ACTIVITY / 2 - BOTTOM_PAD_ACTIVITY;
		
		activity = [[UIActivityIndicatorView alloc] initWithFrame:
					CGRectMake(x, y, WIDTH_ACTIVITY, HEIGHT_ACTIVITY)];
		
		[self.labelContainer addSubview:activity];
		
		float y1 = y + HEIGHT_ACTIVITY + BOTTOM_PAD_ACTIVITY;
		
		labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, y1, rect.size.width, 22.0f)];
		labelText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
		labelText.text = NSLocalizedString(@"Loading...", "Loading from ViewLoading");
		labelText.backgroundColor = [UIColor clearColor];
		labelText.textAlignment = UITextAlignmentCenter;
		labelText.textColor = [UIColor whiteColor];
		
		[self.labelContainer addSubview:labelText];
        
        self.hidden = YES;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	CGRect rect;
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	if ( orientation == UIInterfaceOrientationLandscapeLeft
		|| orientation == UIInterfaceOrientationLandscapeRight )
		
		rect = CGRectMake(0, 0, 480, 320);
	else
		rect = CGRectMake(0, 0, 320, 480);
	
    if ((self = [super initWithFrame:rect])) {
        // Initialization code
		
		//self.backgroundColor = [UIColor blackColor];
		self.alpha = 1.0f;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth
		| UIViewAutoresizingFlexibleHeight
		;
		
		
		self.labelContainer = [[[UIView alloc] initWithFrame:frame] autorelease];
		self.labelContainer.backgroundColor = [UIColor blackColor];
		self.labelContainer.alpha = 0.7f;
		self.labelContainer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
		| UIViewAutoresizingFlexibleRightMargin
		| UIViewAutoresizingFlexibleTopMargin
		| UIViewAutoresizingFlexibleBottomMargin;
		[self addSubview:labelContainer];
		self.labelContainer.layer.cornerRadius = 10;
		
		
		
		float x = frame.size.width / 2 - WIDTH_ACTIVITY / 2;
		float y = frame.size.height / 2 - HEIGHT_ACTIVITY / 2 - BOTTOM_PAD_ACTIVITY;
		
		activity = [[UIActivityIndicatorView alloc] initWithFrame:
					CGRectMake(x, y, WIDTH_ACTIVITY, HEIGHT_ACTIVITY)];
		
		[self.labelContainer addSubview:activity];
		
		float y1 = y + HEIGHT_ACTIVITY + BOTTOM_PAD_ACTIVITY;
		
		labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, y1, frame.size.width, 22.0f)];
		labelText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)]; //[UIFont fontWithName:@"Helvetica Bold" size:(36.0)];
		labelText.text = NSLocalizedString(@"Loading...", "Loading from ViewLoading");
		labelText.backgroundColor = [UIColor clearColor];
		labelText.textAlignment = UITextAlignmentCenter;
		labelText.textColor = [UIColor whiteColor];
		
		//[UIFont fontWithName:@"Arial Rounded MT Bold" size:(36.0)];
        
		
		[self.labelContainer addSubview:labelText];
		
    }
    return self;
}

- (void)fixRotation {
	CGRect rect;
	
	if ([ViewLoading isLandscape])
		rect = CGRectMake(0, 0, 480, 320);
	else 
		rect = CGRectMake(0, 0, 320, 480);
	
	self.frame = rect;
}

+ (ViewLoading *)createCenterLoading {
	
	ViewLoading *vl;
	
	if ( [ViewLoading isLandscape] ) {
		vl = [[[ViewLoading alloc] initWithFrame:
			   CGRectMake(180, 100, 120, 120)] autorelease];
	} else {
		vl = [[[ViewLoading alloc] initWithFrame:
			   CGRectMake(100, 180, 120, 120)] autorelease];
	}
	
	return vl;
}

+ (BOOL)isLandscape {
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	if ( orientation == UIInterfaceOrientationLandscapeLeft
		|| orientation == UIInterfaceOrientationLandscapeRight )
		
		return YES;
	else
		return NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (void)startLoading {
    self.hidden = NO;
	[activity startAnimating];
}

- (void)stopLoading {
    self.hidden = YES;
	[activity stopAnimating];
}

- (void)dealloc {
	self.labelContainer = nil;
	self.activity = nil;
	self.labelText = nil;
	
	[labelContainer release];
	[activity release];
	[labelText release];
	
	[super dealloc];
}

@end
