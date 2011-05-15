//
//  BaseDataEntryCell.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseDataEntryCell.h"


@implementation BaseDataEntryCell

@synthesize dataKey;
@synthesize superViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.textLabel.font  = [UIFont boldSystemFontOfSize:14] ;	
		
    }
    return self;
}


- (void)setControlValue:(id)value
{
}

- (id)getControlValue
{
	return nil;
}

- (void)postEndEditingNotification
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:CELL_ENDEDIT_NOTIFICATION_NAME
	 object:[(UITableView *)self.superview indexPathForCell: self]]; // Passa il proprio IndexPath
}

- (BOOL)getBooleanValue {
	return YES;
}

- (void)savePersistence {
}

- (void)dealloc {
    self.superViewController = nil;
    [superViewController release];
    [super dealloc];
}


@end