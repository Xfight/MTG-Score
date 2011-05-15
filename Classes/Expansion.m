//
//  Expansion.m
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Expansion.h"


@implementation Expansion

@synthesize name, arrayUrlLanguage;

- (id)init
{
	if ( (self = [super init]) ) {
		// initialization
        self.name = @"";
        self.arrayUrlLanguage = [NSMutableArray array];
	}
	
	return self;
}

- (void)dealloc
{
    [name release];
    [arrayUrlLanguage release];
    [super dealloc];
}

@end
