//
//  PlayerStatus.m
//  MTG Score
//
//  Created by Luca on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerStatus.h"


@implementation PlayerStatus

@synthesize life,infect,timestamp;

- (id)initWithLife:(int)aLife andInfect:(int)aInfect
{
    if ((self = [super init]))
    {
        life = aLife;
        infect = aInfect;
        self.timestamp = [NSDate date];
    }
    
    return self;
}

+ (id)playerStatusLife:(int)aLife andInfect:(int)aInfect
{
    return [[[PlayerStatus alloc] initWithLife:aLife andInfect:aInfect] autorelease];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"life : %d, infect : %d", life, infect];
}

- (void)dealloc
{
    [timestamp release];
    [super dealloc];
}

@end
