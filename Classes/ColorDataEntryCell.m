//
//  ColorDataEntryCell.m
//  MTG SK
//
//  Created by Luca on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ColorDataEntryCell.h"


@implementation ColorDataEntryCell
@synthesize label;
@synthesize groupTableColor;

- (void)labelTouch:(id)sender
{
	ColorDataChoose *v = [[ColorDataChoose alloc] init];
	v.colorForViewBackground = self.label.backgroundColor;
	v.colorDataEntryCell = self;
	v.groupTableColor = [DataAccess boolForKey:K_BACKGROUND_COLOR_TABLE];
    
    [self.superViewController presentModalViewController:v animated:YES];
	[v release];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.label = [UIButton buttonWithType:UIButtonTypeCustom];
		
		[self.label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		self.label.contentEdgeInsets = UIEdgeInsetsMake(0.0, 75.0, 0.0, 0.0);
		
		self.label.layer.borderColor = [[UIColor blackColor] CGColor];
		[self.label.layer setBorderWidth: 2.0];
        
		[self.label addTarget:self action:@selector(labelTouch:)forControlEvents:UIControlEventTouchDown];
		
		[self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// La label occupaupa il 35% del container
	CGRect labelRect = CGRectMake(self.textLabel.frame.origin.x, 
								  self.textLabel.frame.origin.y, 
								  self.contentView.frame.size.width * .60, 
								  self.textLabel.frame.size.height);
	[self.textLabel setFrame:labelRect];
	
	// Rect area del textbox
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING, 
							 9.0, 
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING, 
							 25.0);
	
	[label setFrame:rect];
}

- (void)setValueAndNotify:(id)value groupTable:(BOOL)boolean
{
	// il value passato è un UIColor
	
	UIColor *c = (UIColor *) value;
	self.label.backgroundColor = c;
	[DataAccess setBool:boolean forKey:K_BACKGROUND_COLOR_TABLE];
	
	[self postEndEditingNotification];
}

- (void)setControlValue:(id)value
{
	// il value passato è un UIColor
	UIColor *c = (UIColor *) value;
	self.label.backgroundColor = c;
}

- (id)getControlValue
{
	return self.label.backgroundColor;
}

- (void)dealloc {
	self.label = nil;
    self.superViewController = nil;
    [superViewController release];
	[label release];
    [super dealloc];
}

@end