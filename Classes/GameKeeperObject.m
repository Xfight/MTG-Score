//
//  GameKeeperObject.m
//  MTG Score
//
//  Created by Luca Bertani on 18/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "GameKeeperObject.h"


@implementation GameKeeperObject
@synthesize gamePlayer1, gamePlayer2, outcome, timestamp;

- (id)init
{
    if (( self = [super init] ))
    {
    }
    
    return self;
}

- (void)setGame:(int)result storyPlayer1:(NSArray *)player1 storyPlayer2:(NSArray *)player2 timestamp:(NSDate *)t
{
    self.gamePlayer1 = player1;
    self.gamePlayer2 = player2;
    self.outcome = result;
    self.timestamp = t;
}

- (void)dealloc
{
    [gamePlayer1 release];
    [gamePlayer2 release];
    [timestamp release];
    
    [super dealloc];
}

@end
