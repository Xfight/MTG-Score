//
//  GameHistory.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameSingle;

@interface GameHistory : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * gamewin;
@property (nonatomic, retain) NSString * player1name;
@property (nonatomic, retain) NSNumber * gamelose;
@property (nonatomic, retain) NSString * player2deck;
@property (nonatomic, retain) NSString * player1deck;
@property (nonatomic, retain) NSNumber * outcome;
@property (nonatomic, retain) NSNumber * gametie;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * player2name;
@property (nonatomic, retain) NSSet* whoGameSingle;

@end
