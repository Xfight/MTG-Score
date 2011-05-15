//
//  ObjectTableCell.m
//  MTG Score
//
//  Created by Luca on 20/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectTableCell.h"


@implementation ObjectTableCell
@synthesize reuseIdentifier, tableCellType, obj, tag, text, title;

- (id)initWithTitle:(NSString *)aTitle andText:(NSString *)aText andObj:(id)aObj andTag:(int)aTag andReuseIdentifier:(NSString *)aReuseIdentifier andTableCellType:(NSString *)aTableCellType
{
    if ((self = [super init]))
    {
        self.title = aTitle;
        self.text = aText;
        self.obj = aObj;
        self.tag = aTag;
        self.reuseIdentifier = aReuseIdentifier;
        self.tableCellType = aTableCellType;
    }
    
    return self;
}

+ (ObjectTableCell *)objectTableCell:(NSString *)aTitle andText:(NSString *)aText andObj:(id)aObj andTag:(int)aTag andReuseIdentifier:(NSString *)aReuseIdentifier andTableCellType:(NSString *)aTableCellType
{
    return [[[ObjectTableCell alloc] initWithTitle:aTitle andText:aText  andObj:(id)aObj andTag:aTag andReuseIdentifier:aReuseIdentifier andTableCellType:aTableCellType] autorelease];
}

- (void)dealloc
{
    [reuseIdentifier release];
    [tableCellType release];
    [text release];
    [title release];
    
    [super dealloc];
}

@end
