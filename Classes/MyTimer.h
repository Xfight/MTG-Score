//
//  MyTimer.h
//  MTG SK
//
//  Created by Luca on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libkern/OSAtomic.h>

#define kStartDate	@"MyTimerStartDate"
#define kEndDate	@"MyTimerEndDate"
#define kEndHour	@"MyTimerEndHour"
#define kEndMinute	@"MyTimerEndMinute"
#define kEndSecond	@"MyTimerEndSecond"
#define kReverseTimer @ "MyTimerReverseTimer"
#define kAlarmOnTenMinutes @"MyTimerAlarmOnTenMinutes"
#define kAlarmOnEndTime @"MyTimerAlarmOnEndTime"
#define kTextAlarmOnTenMinutes @"MyTimerTextAlarmOnTenMinutes"
#define kTextAlarmOnEndTime @"MyTimerTextAlarmOnEndTime"

#define kActualHour   @"MyTimerActualHour"
#define kActualMinute @"MyTimerActualMinute"
#define kActualSecond @"MyTimerActualSecond"

@interface MyTimer : NSObject {
	// timer that occurence each interval
	NSTimer *timer;
	
	// label for write timer
	UILabel *labelTimer;
	
	// current time
	int32_t hour, minute, second;
	
	// reverse current time
	BOOL reverseTimer;
	int32_t hourEnd, minuteEnd, secondEnd;
	
	// alarm
	BOOL alarmOnTenMinutes;
	NSString *textAlarmOnTenMinutes;
	BOOL alarmOnEndTime;
	NSString *textAlarmOnEndTime;
}

@property (nonatomic, retain) UILabel *labelTimer;

@property BOOL reverseTimer;
@property BOOL alarmOnTenMinutes;
@property BOOL alarmOnEndTime;
@property (copy) NSString *textAlarmOnTenMinutes;
@property (copy) NSString *textAlarmOnEndTime;

- (id)initWithLabel:(UILabel *)label;

- (void)startTimer;
- (void)startOnlyTimer;
- (void)stopTimer;
- (void)stopTimerAndReset;
- (void)freezeTimer;
- (void)resumeTimer:(BOOL)withIncrease;
- (void)resumeTimerFromLockScreen;
- (void)timerRefresh;
- (BOOL)isEnabled;

- (void)setReverseTimerWithHours:(int)h minutes:(int)m seconds:(int)s;

@end