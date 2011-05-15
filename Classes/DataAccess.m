//
//  DataAccess.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataAccess.h"


@implementation DataAccess

+ (BOOL)rotationCheck:(UIInterfaceOrientation)now withOldInterfaceRotation:(UIInterfaceOrientation)oldInterfaceRotation
{
    //UIInterfaceOrientation now = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ( now == UIInterfaceOrientationLandscapeLeft || now == UIInterfaceOrientationLandscapeRight ) {
        if ( oldInterfaceRotation == UIInterfaceOrientationPortrait ) {
            return YES;
        }
    } else if ( now == UIInterfaceOrientationPortrait ) {
        if ( oldInterfaceRotation == UIInterfaceOrientationLandscapeLeft || oldInterfaceRotation == UIInterfaceOrientationLandscapeRight ) {
                return YES;
        }
    }
    
    return NO;
}

+ (void)forseSync {
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)setObject:(id)object forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

+ (UIColor *)colorForKey:(NSString *)key
{	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	if ( [key isEqualToString:K_BACKGROUND_COLOR] && [pref boolForKey:K_BACKGROUND_COLOR_TABLE] )
		return [UIColor groupTableViewBackgroundColor];
	
	float red = [pref floatForKey:[NSString stringWithFormat:@"%@Red", key]];
	float green = [pref floatForKey:[NSString stringWithFormat:@"%@Green", key]];
	float blue = [pref floatForKey:[NSString stringWithFormat:@"%@Blue", key]];
	float alpha = [pref floatForKey:[NSString stringWithFormat:@"%@Alpha", key]];
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+ (void)setColor:(UIColor *)color forKey:(NSString *)key
{
	const CGFloat *components = CGColorGetComponents([color CGColor]);
	
	float red = components[0];
	float green = components[1];
	float blue = components[2];
	float alpha = components[3];
	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	[pref setFloat:red forKey:[NSString stringWithFormat:@"%@Red", key]];
	[pref setFloat:green forKey:[NSString stringWithFormat:@"%@Green", key]];
	[pref setFloat:blue forKey:[NSString stringWithFormat:@"%@Blue", key]];
	[pref setFloat:alpha forKey:[NSString stringWithFormat:@"%@Alpha", key]];
}

+ (BOOL)boolForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
+ (void)setBool:(BOOL)object forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setBool:object forKey:key];
}

+ (int)intForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}
+ (void)setInt:(int)n forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setInteger:n forKey:key];
}

+ (float)floatForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}
+ (void)setFloat:(float)n forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setFloat:n forKey:key];
}

@end
