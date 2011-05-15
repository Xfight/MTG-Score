//
//  RotatingDatePicker.m
//  MTG SK
//
//  Created by Luca on 18/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RotatingDatePicker.h"


@implementation RotatingDatePicker

- (id)initWithFrame: (CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        for (UIView * subview in self.subviews) {
            subview.frame = self.bounds;
        }
    }
    return self;
}

- (id) initWithCoder: (NSCoder *)aDecoder {
    if ((self = [super initWithCoder: aDecoder])) {
        for (UIView * subview in self.subviews) {
            subview.frame = self.bounds;
        }
    }
    return self;
}



@end