//
//  GameSingle.m
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import "GameSingle.h"
#import "GameHistory.h"
#import "GameLineStatus.h"


@implementation GameSingle
@dynamic outcome;
@dynamic timestamp;
@dynamic numberGame;
@dynamic whoGameStatus;
@dynamic whoHistory;

- (void)addWhoGameStatusObject:(GameLineStatus *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"whoGameStatus"] addObject:value];
    [self didChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWhoGameStatusObject:(GameLineStatus *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"whoGameStatus"] removeObject:value];
    [self didChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWhoGameStatus:(NSSet *)value {    
    [self willChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"whoGameStatus"] unionSet:value];
    [self didChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWhoGameStatus:(NSSet *)value {
    [self willChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"whoGameStatus"] minusSet:value];
    [self didChangeValueForKey:@"whoGameStatus" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
