//
//  TextDataEntryCell.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextDataEntryCell.h"


@implementation TextDataEntryCell

@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {	
		// Configuro il textfield secondo la necessità
		self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
		self.textField.clearsOnBeginEditing = NO;
		self.textField.textAlignment = UITextAlignmentLeft;
		self.textField.returnKeyType = UIReturnKeyDone;
		self.textField.font = [UIFont systemFontOfSize:14];		
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.textField.delegate = self;
		
		[self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// La label occupaupa il 35% del container
	CGRect labelRect = CGRectMake(self.textLabel.frame.origin.x, 
								  self.textLabel.frame.origin.y, 
								  self.contentView.frame.size.width * .35, 
								  self.textLabel.frame.size.height);
	[self.textLabel setFrame:labelRect];
	
	// Rect area del textbox
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING, 
							 12.0, 
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING, 
							 25.0);
	
	[textField setFrame:rect];
}

- (void)setControlValue:(id)value
{
	self.textField.text = value;
}

- (id)getControlValue
{
	return self.textField.text;
}


#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)txtField
{
	[self postEndEditingNotification];
}

- (void)dealloc {
	self.textField = nil;
	[textField release];
    [super dealloc];
}


@end
