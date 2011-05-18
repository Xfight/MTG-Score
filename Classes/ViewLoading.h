//
//  ViewLoading.h
//  MTG SK
//
//  Created by Luca on 26/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define kTimerWaitBeforeCancel  10

@class ViewLoading;

@protocol ViewLoadingDelegate <NSObject>
- (void)viewLoadingDidCancelLoading:(ViewLoading *)viewLoading;
@end

@interface ViewLoading : UIView {
	UILabel *labelContainer;
	UIActivityIndicatorView *activity;
	UILabel *labelText;
    NSTimer *timer;
    BOOL canCancel;
    
    id<ViewLoadingDelegate> delegate;
}

@property (nonatomic, retain) UILabel *labelContainer;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UILabel *labelText;
@property (nonatomic) BOOL canCancel;
@property (assign) id<ViewLoadingDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andCenterPoint:(CGPoint)center;
+ (ViewLoading *)createCenterLoading;
+ (BOOL)isLandscape;
- (void)startLoading;
- (void)stopLoading;
- (void)fixRotation;

@end
