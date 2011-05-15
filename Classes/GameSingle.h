//
//  GameSingle.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameHistory, GameLineStatus;

@interface GameSingle : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * outcome;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * numberGame;
@property (nonatomic, retain) NSSet* whoGameStatus;
@property (nonatomic, retain) GameHistory * whoHistory;

@end
