//
//  DataAccess.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPlayer1	@"pl1"
#define kPlayer2	@"pl2"
#define K_REVERSE_COUNT_TIME	@"reverseCountTime"
#define K_REVERSE_HOUR			@"reverseHour"
#define K_REVERSE_MINUTE		@"reverseMinute"
#define K_REVERSE_SECOND		@"reverseSecond"
#define K_POISON	@"poison"
#define K_ALARM_ON_TEN_MINUTES	@"alarmOnTenMinutes"
#define K_ALARM_ON_END_TIME		@"alarmOnEndTime"
#define K_DISPLAY_SLEEP			@"displaySleep"
#define K_BACKGROUND_COLOR		@"backgroundColor"
#define K_BACKGROUND_COLOR_TABLE @"backgroundColorTable"
#define K_TEXT_TIMER_COLOR		@"textTimerColor"
#define K_ENABLE_TIMER			@"enableTimer"
#define K_ENABLE_HISTORY        @"enableHistory"

#define kLanguageApp            @"languageSelection"
#define kLanguageAutomatic      @"Default"

#define kInit	@"init"
#define kVersion	@"version"

@interface DataAccess : NSObject {

}

+ (BOOL)rotationCheck:(UIInterfaceOrientation)now withOldInterfaceRotation:(UIInterfaceOrientation)oldInterfaceRotation;

+ (void)forseSync;

+ (id)objectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

+ (UIColor *)colorForKey:(NSString *)key;
+ (void)setColor:(UIColor *)color forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;
+ (void)setBool:(BOOL)object forKey:(NSString *)key;

+ (int)intForKey:(NSString *)key;
+ (void)setInt:(int) n forKey:(NSString *)key;

+ (float)floatForKey:(NSString *)key;
+ (void)setFloat:(float) n forKey:(NSString *)key;

@end
