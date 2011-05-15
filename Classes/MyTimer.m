//
//  MyTimer.m
//  MTG SK
//
//  Created by Luca on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyTimer.h"

@interface MyTimer()

- (void)startOnlyTimer;

@end


@implementation MyTimer

@synthesize labelTimer, reverseTimer, alarmOnTenMinutes, alarmOnEndTime;
@synthesize textAlarmOnTenMinutes, textAlarmOnEndTime;

- (id)init
{
	if ( (self = [super init]) ) {
		// initalization
	}
	
	return self;
}

- (id)initWithLabel:(UILabel *)label
{
	if ( (self = [super init]) ) {
		// init
		self.labelTimer = label;
		
		second = minute = hour = 0;
		
		self.reverseTimer = NO;
		secondEnd = minuteEnd = hourEnd = 0;
		
		self.alarmOnTenMinutes = NO;
		self.alarmOnEndTime = NO;
		
		self.textAlarmOnTenMinutes = NSLocalizedString(@"TEN MINUTES !", @"10 minutes at the end of time");
		self.textAlarmOnEndTime = NSLocalizedString(@"END TIME !", @"Time up!");
	}
	
	return self;
}

- (void)startOnlyTimer
{
	if ( timer == nil ) {
		//self.labelTimer.text = @"00:00:00";
		timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerIncrease:) userInfo:nil repeats:YES] retain];
	}
}

- (void)startTimer
{
	if ( self.reverseTimer )
		self.labelTimer.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hourEnd, minuteEnd, secondEnd];
	else
		self.labelTimer.text = @"00:00:00";
	
	second = minute = hour = 0;
	
	// stopTimer ferma e dealloca timer
	[self stopTimer];
	timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerIncrease:) userInfo:nil repeats:YES] retain];
	
	/*if ( timer == nil ) {
		timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerIncrease) userInfo:nil repeats:YES] retain];
	}*/
}

// semplicemente ferma il timer
- (void)stopTimer
{
	if ( timer ) {
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

- (BOOL)isEnabled
{
    return timer!=nil;
}

// ferma il timer e lo resetta completamente
- (void)stopTimerAndReset
{
	if ( timer ) {
		[timer invalidate];
		[timer release];
		timer = nil;
	}
	
	if ( self.reverseTimer )
		self.labelTimer.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hourEnd, minuteEnd, secondEnd];
	else
		self.labelTimer.text = @"00:00:00";
	
	second = minute = hour = 0;
}

/*- (void)resetTimer
{
	if ( timer ) {
		[timer invalidate];
		[timer release];
		timer = nil;
	}
	
	[self startTimer];
}*/

- (void)freezeTimer
{
	//endDate = [NSDate date];
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	[pref setObject:[NSDate date] forKey:kEndDate];
	[pref setBool:self.reverseTimer forKey:kReverseTimer];
	[pref setInteger:hourEnd forKey:kEndHour];
	[pref setInteger:minuteEnd forKey:kEndMinute];
	[pref setInteger:secondEnd forKey:kEndSecond];
	[pref setBool:self.alarmOnEndTime forKey:kAlarmOnEndTime];
	[pref setBool:self.alarmOnTenMinutes forKey:kAlarmOnTenMinutes];
	[pref setObject:self.textAlarmOnEndTime forKey:kTextAlarmOnEndTime];
	[pref setObject:self.textAlarmOnTenMinutes forKey:kTextAlarmOnTenMinutes];
    
    [pref setInteger:hour forKey:kActualHour];
    [pref setInteger:minute forKey:kActualMinute];
    [pref setInteger:second forKey:kActualSecond];
	
	[pref synchronize];
	
	[self stopTimer];
}

- (void)resumeTimerFromLockScreen
{
    /*if ( timer != nil ) [self stopTimer];
    
  
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *components = [gregorian components:unitFlags
                                                    fromDate:self.startDate
                                                      toDate:[NSDate date] options:0];
        int h = [components hour];
        int m = [components minute];
        int s = [components second];
        
        second = s;
        minute = m;
        hour = h;
        
        [gregorian release];*/
}

- (void)resumeTimer:(BOOL) withIncrease
{
	if ( timer != nil ) [self stopTimer];
	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	self.reverseTimer = [pref boolForKey:kReverseTimer];
	hourEnd = [pref integerForKey:kEndHour];
	minuteEnd = [pref integerForKey:kEndMinute];
	secondEnd = [pref integerForKey:kEndSecond];
	self.alarmOnEndTime = [pref boolForKey:kAlarmOnEndTime];
	self.alarmOnTenMinutes = [pref boolForKey:kAlarmOnTenMinutes];
	self.textAlarmOnEndTime = [pref objectForKey:kTextAlarmOnEndTime];
	self.textAlarmOnTenMinutes = [pref objectForKey:kTextAlarmOnTenMinutes];
	
	// e' stato uno stop oppure un ripristino da chiusura applicazione ?
	if ( withIncrease ) {
		// ripristino, quindi incremento il tempo perso
        NSDate *oldDate = [pref objectForKey:kEndDate];
		NSCalendar *gregorian = [[NSCalendar alloc]
								 initWithCalendarIdentifier:NSGregorianCalendar];
		unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		NSDateComponents *components = [gregorian components:unitFlags
													fromDate:oldDate
													  toDate:[NSDate date] options:0];
        
        second = [components second] + [pref integerForKey:kActualSecond];
        minute = hour = 0;
        if ( second > 60 )
        {
            second -=60;
            minute += 1;
        }
        
        minute = minute + [components minute] + [pref integerForKey:kActualMinute];
        if ( minute > 60 )
        {
            minute -= 60;
            hour += 1;
        }
        
        hour = hour + [components hour] + [pref integerForKey:kActualHour];
        
		/*int h = [components hour];
		int m = [components minute];
		int s = [components second];
		
		second = s;
		minute = m;
		hour = h;*/
		
		[gregorian release];
		
	} else {
		// semplice stop & resume
        
        second = [pref integerForKey:kActualSecond];
        minute = [pref integerForKey:kActualMinute];
        hour = [pref integerForKey:kActualHour];
		
		/*NSDate *stopDate = [pref objectForKey:kEndDate];
		
		NSCalendar *gregorian = [[NSCalendar alloc]
								 initWithCalendarIdentifier:NSGregorianCalendar];
		unsigned int unitFlags = NSSecondCalendarUnit;
		NSDateComponents *components = [gregorian components:unitFlags
													fromDate:stopDate
													  toDate:[NSDate date] options:0];
		
		NSDate *temp = [self.startDate dateByAddingTimeInterval: [components second]];
		
        NSLog(@"start : %@", self.startDate);
		self.startDate = temp;
        NSLog(@"new start : %@", self.startDate);
		
		unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		components = [gregorian components:unitFlags
								fromDate:self.startDate
								toDate:[NSDate date] options:0];
		int h = [components hour];
		int m = [components minute];
		int s = [components second];
		
		second = s;
		minute = m;
		hour = h;
		
		[gregorian release];*/
	}
	
	/*[self startOnlyTimer];
	[self timerRefresh];*/
	
}

- (void)setReverseTimerWithHours:(int)h minutes:(int)m seconds:(int)s
{
	// atomic swap !
	/*OSAtomicCompareAndSwapInt(hourEnd, h, &hourEnd);
	 OSAtomicCompareAndSwapInt(minuteEnd, m, &minuteEnd);
	 OSAtomicCompareAndSwapInt(secondEnd, s, &secondEnd);*/
	
	hourEnd = h;
	minuteEnd = m;
	secondEnd = s;
	
	self.reverseTimer = YES;
	
	//[self timerRefresh];
}

#pragma mark -
#pragma mark Timer Refresh

- (void)timerIncrease:(NSTimer*)theTimer
{
	second += 1;
	[self timerRefresh];
}

- (void)timerRefresh
{
	// do a lot of work !!
    if ( second == 60 ) {
		minute += 1;
		second = 0;
	}
	if ( minute == 60 ) {
		hour += 1;
		minute = 0;
	}
    
    int s1 = secondEnd - second;
    int m1 = minuteEnd;
    int h1 = hourEnd;
    
    if ( s1 < 0 ) {
        m1 -= 1;
        s1 += 60;
    }
    
    m1 = m1 - minute;
    if ( m1 < 0 ) {
        h1 -= 1;
        m1 += 60;
    }
    
    h1 = h1 - hour;
    
    NSString *s;
    
    if ( self.reverseTimer )
    {
        if ( h1 >= 0 )
			s = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", h1, m1, s1];
		else {
			s = @"00:00:00";
			[self stopTimer];
		}
        
        if ( self.alarmOnTenMinutes && s1 == 0 && m1 == 10 && h1 == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnTenMinutes delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		} else if ( self.alarmOnEndTime && s1 == 0 && m1 == 0 && h1 == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnEndTime delegate:self cancelButtonTitle:@"OK"  otherButtonTitles: nil ];
			[alert show];
			[alert release];
		}
        
    } else
    {
        if ( h1 >= 0 )
            s = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hour,minute,second];
		else {
			s = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hourEnd,minuteEnd,secondEnd];
			[self stopTimer];
		}
        
        if ( self.alarmOnTenMinutes && second == 0 && (minuteEnd - minute) == 10 && (hourEnd - hour) == 0 ) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnTenMinutes delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		} else if ( self.alarmOnEndTime && second == 0 && (minuteEnd - minute) == 0 && (hourEnd - hour) == 0 ) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnEndTime delegate:self cancelButtonTitle:@"OK"  otherButtonTitles: nil ];
			[alert show];
			[alert release];
		} 
    }
    
    self.labelTimer.text = s;
    
	
	/*if ( second == 60 ) {
		minute += 1;
		second = 0;
	}
	if ( minute == 60 ) {
		hour += 1;
		minute = 0;
	}
	
	NSString *s;
	
	if ( self.reverseTimer ) {
		
		int s1 = secondEnd - second;
		int m1 = minuteEnd;
		int h1 = hourEnd;
		
		if ( s1 < 0 ) {
			m1 -= 1;
			s1 += 60;
		}
		
		m1 = m1 - minute;
		if ( m1 < 0 ) {
			h1 -= 1;
			m1 += 60;
		}
		
		h1 = h1 - hour;
		
		if ( h1 >= 0 )
			s = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", h1, m1, s1];
		else {
			s = @"00:00:00";
			[self stopTimer];
		}
		
		if ( self.alarmOnTenMinutes && h1 == 0 && m1 == 10 && s1 == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnTenMinutes delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		} else if ( self.alarmOnEndTime && h1 == 0 && m1 == 0 && s1 == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnEndTime delegate:self cancelButtonTitle:@"OK"  otherButtonTitles: nil ];
			[alert show];
			[alert release];
		}
		
	} else {
        if ( self.alarmOnTenMinutes && (hourEnd - hour) == 0 && (minuteEnd - minute) == 10 && second == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnTenMinutes delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		} else if ( self.alarmOnEndTime && (hourEnd - hour) == 0 && (minuteEnd - minute) == 0 && second == 0) {
			// go alert !
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT !" message:self.textAlarmOnEndTime delegate:self cancelButtonTitle:@"OK"  otherButtonTitles: nil ];
			[alert show];
			[alert release];
		} 
        
        s = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hour,minute,second];
	}
	
	self.labelTimer.text = s;*/
}

- (void)dealloc
{	
	if ( timer ) {
		[self stopTimer];
	}
	
	self.labelTimer = nil;
	self.textAlarmOnTenMinutes = nil;
	self.textAlarmOnEndTime = nil;
	
	[labelTimer release];
	[textAlarmOnTenMinutes release];
	[textAlarmOnEndTime release];
	
	[super dealloc];
}



@end