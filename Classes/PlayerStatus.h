//
//  PlayerStatus.h
//  MTG Score
//
//  Created by Luca on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayerStatus : NSObject {
    int life;
    int infect;
    NSDate *timestamp;
}

@property int life;
@property int infect;
@property (nonatomic, retain) NSDate *timestamp;

- (id)initWithLife:(int)aLife andInfect:(int)aInfect;
+ (id)playerStatusLife:(int)aLife andInfect:(int)aInfect;

@end
