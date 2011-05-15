//
//  EditableTableCell.m
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "EditableTableCell.h"


@implementation EditableTableCell
@synthesize myLabel, myTextField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //[myTextField becomeFirstResponder];
}

- (void)dealloc
{
    [myTextField release];
    [myLabel release];
    [super dealloc];
}

@end
