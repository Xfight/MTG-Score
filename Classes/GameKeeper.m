//
//  GameKeeper.m
//  MTG Score
//
//  Created by Luca Bertani on 18/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "GameKeeper.h"
#import "CoreDataManager.h"

@interface GameKeeper()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation GameKeeper
@synthesize arrayGameKeeperObject, managedObjectContext;

static GameKeeper* _sharedGameKeeper = nil;

+ (GameKeeper *)sharedGameKeeper
{
	@synchronized([GameKeeper class])
	{
		if (!_sharedGameKeeper)
			[[self alloc] init];
        
		return _sharedGameKeeper;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([GameKeeper class])
	{
		NSAssert(_sharedGameKeeper == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedGameKeeper = [super alloc];
		return _sharedGameKeeper;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
        self.arrayGameKeeperObject = [NSMutableArray arrayWithCapacity:2];
	}
    
	return self;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if ( managedObjectContext == nil )
        managedObjectContext = [[[CoreDataManager sharedCoreDataManager] managedObjectContext] retain];
    
    return managedObjectContext;
}


- (void)insertGameOutcome:(int)result storyPlayer1:(NSArray *)storyPlayer1 storyPlayer2:(NSArray *)storyPlayer2 timestamp:(NSDate *)t
{
    GameKeeperObject *gko = [[GameKeeperObject alloc] init];
    [gko setGame:result storyPlayer1:storyPlayer1 storyPlayer2:storyPlayer2 timestamp:t];
    
    [self.arrayGameKeeperObject addObject:gko];
    [gko release];
}

- (void)saveGameHistory:(NSDate *)dateStartMatch outcome:(int)outcome player1name:(NSString *)p1n player1deck:(NSString *)p1d   player2name:(NSString *)p2n player2deck:(NSString *)p2d
{
    GameHistory *gameHistory = [NSEntityDescription insertNewObjectForEntityForName:@"GameHistory" inManagedObjectContext:self.managedObjectContext];
    
    int gameloose = 0;
    int gamewin = 0;
    int gamedraw = 0;
    
    int numberGame = 1;
    
    gameHistory.outcome = [NSNumber numberWithInt:outcome];
    gameHistory.player1name = p1n;
    gameHistory.player1deck = p1d;
    gameHistory.player2name = p2n;
    gameHistory.player2deck = p2d;
    gameHistory.timestamp = dateStartMatch;
    
    NSArray *gamePlayer1;
    NSArray *gamePlayer2;
    PlayerStatus *playerStatus;
    
    
    for (GameKeeperObject *gko in self.arrayGameKeeperObject) {
        GameSingle *gameSingle = [NSEntityDescription insertNewObjectForEntityForName:@"GameSingle" inManagedObjectContext:self.managedObjectContext];
        
        gameSingle.timestamp = gko.timestamp;
        gameSingle.outcome = [NSNumber numberWithInt:gko.outcome];
        gameSingle.whoHistory = gameHistory;
        gameSingle.numberGame = [NSNumber numberWithInt:numberGame++];
        
        int len = [gko.gamePlayer1 count];
        gamePlayer1 = gko.gamePlayer1;
        gamePlayer2 = gko.gamePlayer2;
        
        
        for (int i = 0; i < len; i++) {
            GameLineStatus *gameLineStatus = [NSEntityDescription insertNewObjectForEntityForName:@"GameLineStatus" inManagedObjectContext:self.managedObjectContext];
            
            playerStatus = [gamePlayer1 objectAtIndex:i];
            gameLineStatus.player1infect = [NSNumber numberWithInt:playerStatus.infect];
            gameLineStatus.player1life = [NSNumber numberWithInt:playerStatus.life];
            
            playerStatus = [gamePlayer2 objectAtIndex:i];
            gameLineStatus.player2infect = [NSNumber numberWithInt:playerStatus.infect];
            gameLineStatus.player2life = [NSNumber numberWithInt:playerStatus.life];
            
            gameLineStatus.timestamp = playerStatus.timestamp;
            gameLineStatus.refeerToGameSingle = gameSingle;
        }
    }
    
    gameHistory.gamewin = [NSNumber numberWithInt:gamewin];
    gameHistory.gametie = [NSNumber numberWithInt:gamedraw];
    gameHistory.gamelose = [NSNumber numberWithInt:gameloose];
    
    [[CoreDataManager sharedCoreDataManager] saveCurrentContext];
    
    [self.arrayGameKeeperObject removeAllObjects];
}

- (void)clean
{
    [self.arrayGameKeeperObject removeAllObjects];
}

- (void)dealloc
{
    [arrayGameKeeperObject release];
    [super dealloc];
}

@end
