//
//  ColorDataEntryCell.h
//  MTG SK
//
//  Created by Luca on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataEntryCell.h"
#import "ColorDataChoose.h"
#import <QuartzCore/QuartzCore.h>
#import "DataAccess.h"

@interface ColorDataEntryCell : BaseDataEntryCell {
	UIButton *label;
	BOOL groupTableColor;
}

@property (nonatomic, retain) UIButton *label;
@property (nonatomic) BOOL groupTableColor;

- (void)labelTouch:(id)sender;
- (void)setValueAndNotify:(id)value groupTable:(BOOL)boolean;

@end
