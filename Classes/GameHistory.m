//
//  GameHistory.m
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import "GameHistory.h"
#import "GameSingle.h"


@implementation GameHistory
@dynamic gamewin;
@dynamic player1name;
@dynamic gamelose;
@dynamic player2deck;
@dynamic player1deck;
@dynamic outcome;
@dynamic gametie;
@dynamic timestamp;
@dynamic player2name;
@dynamic whoGameSingle;

- (void)addWhoGameSingleObject:(GameSingle *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"whoGameSingle"] addObject:value];
    [self didChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWhoGameSingleObject:(GameSingle *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"whoGameSingle"] removeObject:value];
    [self didChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWhoGameSingle:(NSSet *)value {    
    [self willChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"whoGameSingle"] unionSet:value];
    [self didChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWhoGameSingle:(NSSet *)value {
    [self willChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"whoGameSingle"] minusSet:value];
    [self didChangeValueForKey:@"whoGameSingle" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
