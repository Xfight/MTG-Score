//
//  TimeDataEntryCell.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataEntryCell.h"
#import "DataAccess.h"
#import "TimeDataChoose.h"

@interface TimeDataEntryCell : BaseDataEntryCell {
	NSDate *date;
}

@property (nonatomic, retain) UIButton *label;

- (void)setValueAndNotify:(id)value;

@end

