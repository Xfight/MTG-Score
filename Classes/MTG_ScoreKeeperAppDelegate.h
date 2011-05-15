//
//  MTG_ScoreKeeperAppDelegate.h
//  MTG ScoreKeeper
//
//  Created by Luca on 18/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewScoreKeeper.h"
#import "ViewSettings.h"
#import "ViewAllSearch.h"
#import "ViewMana.h"
#import "ViewGameHistory.h"
#import "ViewProvaCoreData.h"
#import <CoreData/CoreData.h>

#import "CoreDataManager.h"

#define kViewScoreKeeper	1
#define kViewMana			2
#define kViewSearch         3
#define kViewSettings		4

@interface MTG_ScoreKeeperAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	ViewScoreKeeper *viewScoreKeeper;
    ViewPlayersStatus *viewPlayersStatus;
	ViewMana *viewMana;
    ViewAllSearch *viewAllSearch;
    /*ViewSearch *viewSearch;*/
	ViewSettings *viewSettings;
	
	BOOL rotated;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) ViewScoreKeeper *viewScoreKeeper;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)updateBackgroundColor:(UIColor *) c;
//- (void)propagateRotation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration noView:(int)n;

@end

