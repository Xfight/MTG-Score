//
//  GameKeeper.h
//  MTG Score
//
//  Created by Luca Bertani on 18/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameHistory.h"
#import "GameSingle.h"
#import "GameLineStatus.h"
#import "PlayerStatus.h"
#import "GameKeeperObject.h"

#define kGameResultWin  3
#define kGameResultDraw 1
#define kGameResultLost 0

@interface GameKeeper : NSObject {
    NSMutableArray *arrayGameKeeperObject;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSMutableArray *arrayGameKeeperObject;


+ (GameKeeper *)sharedGameKeeper;
- (void)insertGameOutcome:(int)result storyPlayer1:(NSArray *)storyPlayer1 storyPlayer2:(NSArray *)storyPlayer2 timestamp:(NSDate *)t;
- (void)saveGameHistory:(NSDate *)dateStartMatch outcome:(int)outcome player1name:(NSString *)p1n player1deck:(NSString *)p1d   player2name:(NSString *)p2n player2deck:(NSString *)p2d;
- (void)clean;

@end
