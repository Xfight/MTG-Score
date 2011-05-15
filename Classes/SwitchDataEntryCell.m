//
//  FlagDataEntryCell.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SwitchDataEntryCell.h"


@implementation SwitchDataEntryCell

@synthesize slider;

- (void)switchChange:(id)sender
{
	[self postEndEditingNotification];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {	
		// Configuro il textfield secondo la necessità
		/*self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
		self.textField.clearsOnBeginEditing = NO;
		self.textField.textAlignment = UITextAlignmentLeft;
		self.textField.returnKeyType = UIReturnKeyDone;
		self.textField.font = [UIFont systemFontOfSize:14];		
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.textField.delegate = self;
		
		[self.contentView addSubview:self.textField];*/
		
		self.slider = [[UISwitch alloc] init];
		
		[self.slider addTarget:self
				action:@selector(switchChange:)
				forControlEvents:UIControlEventValueChanged];
		
		[self.contentView addSubview:self.slider];
		
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// La label occupaupa il 35% del container
	CGRect labelRect = CGRectMake(self.textLabel.frame.origin.x, 
								  self.textLabel.frame.origin.y, 
								  self.contentView.frame.size.width * .61, 
								  self.textLabel.frame.size.height);
	[self.textLabel setFrame:labelRect];
	
	// Rect area del textbox
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING, 
							 8.0, 
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING, 
							 25.0);
	
	[self.slider setFrame:rect];
}


/*- (void)savePersistence {
	[DataAccess setBool:self.slider.on forKey:K_REVERSE_COUNT_TIME];
	[DataAccess forseSync];
}*/

-(void) setControlValue:(id)value
{
	NSNumber *n = (NSNumber *) value;
	int i = [n intValue];
	
	if ( i == YES )
		self.slider.on = YES;
	else {
		self.slider.on = NO;
	}
}

-(id) getControlValue
{
	NSNumber *n = [NSNumber numberWithBool:self.slider.on];
	return n;
}

- (BOOL)getBooleanValue {
	return self.slider.on;
}

- (void)dealloc {
	self.slider = nil;
	[slider release];
    [super dealloc];
}


@end