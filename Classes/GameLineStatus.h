//
//  GameLineStatus.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameSingle;

@interface GameLineStatus : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * player2infect;
@property (nonatomic, retain) NSNumber * player1life;
@property (nonatomic, retain) NSNumber * player1infect;
@property (nonatomic, retain) NSNumber * player2life;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) GameSingle * refeerToGameSingle;

@end
