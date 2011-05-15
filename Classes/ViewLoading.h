//
//  ViewLoading.h
//  MTG SK
//
//  Created by Luca on 26/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewLoading : UIView {
	UILabel *labelContainer;
	UIActivityIndicatorView *activity;
	UILabel *labelText;
}

@property (nonatomic, retain) UILabel *labelContainer;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UILabel *labelText;

- (id)initWithFrame:(CGRect)frame andCenterPoint:(CGPoint)center;
+ (ViewLoading *)createCenterLoading;
+ (BOOL)isLandscape;
- (void)startLoading;
- (void)stopLoading;
- (void)fixRotation;

@end
