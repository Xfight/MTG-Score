//
//  GameKeeperObject.h
//  MTG Score
//
//  Created by Luca Bertani on 18/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameKeeperObject : NSObject {
    NSArray *gamePlayer1;
    NSArray *gamePlayer2;
    int outcome;
    NSDate *timestamp;
}

@property (nonatomic, retain) NSArray *gamePlayer1;
@property (nonatomic, retain) NSArray *gamePlayer2;
@property (nonatomic) int outcome;
@property (nonatomic, retain) NSDate *timestamp;

- (void)setGame:(int)result storyPlayer1:(NSArray *)player1 storyPlayer2:(NSArray *)player2 timestamp:(NSDate *)timestamp;

@end
