//
//  MTG_ScoreKeeperAppDelegate.m
//  MTG ScoreKeeper
//
//  Created by Luca on 18/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MTG_ScoreKeeperAppDelegate.h"

@implementation MTG_ScoreKeeperAppDelegate

@synthesize window;
@synthesize viewScoreKeeper;

@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

#pragma mark -
#pragma mark Application lifecycle

- (void)firstStart
{
	[DataAccess setObject:NSLocalizedString(@"Io", @"player 1") forKey:kPlayer1];
	[DataAccess setObject:NSLocalizedString(@"Opponent", @"player 2") forKey:kPlayer2];
	[DataAccess setObject:NSLocalizedString(@"Infect", @"infect token") forKey:K_POISON];
	
	[DataAccess setBool:YES forKey:K_BACKGROUND_COLOR_TABLE];
	[DataAccess setColor:[UIColor groupTableViewBackgroundColor] forKey:K_BACKGROUND_COLOR];
	[DataAccess setColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:K_TEXT_TIMER_COLOR];
	
    [DataAccess setBool:YES forKey:K_ENABLE_HISTORY];
	[DataAccess setBool:YES forKey:K_ENABLE_TIMER];
	[DataAccess setBool:YES forKey:K_REVERSE_COUNT_TIME];
	[DataAccess setInt:0 forKey:K_REVERSE_HOUR];
	[DataAccess setInt:40 forKey:K_REVERSE_MINUTE];
	[DataAccess setInt:0 forKey:K_REVERSE_SECOND];
	[DataAccess setBool:NO forKey:K_ALARM_ON_TEN_MINUTES];
	[DataAccess setBool:NO forKey:K_ALARM_ON_END_TIME];
	[DataAccess setBool:NO forKey:K_DISPLAY_SLEEP];
    
    //[defaults synchronize];
    [DataAccess setObject:kLanguageAutomatic forKey:kLanguageApp];
	
	[DataAccess setBool:YES forKey:kInit];
    [DataAccess setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:kVersion];
	
	[DataAccess forseSync];
}

- (void)updateCurrentVersion:(NSString *)version
{
	[DataAccess setObject:version forKey:kVersion];
    
    int h = [DataAccess intForKey:K_REVERSE_HOUR];
    int m = [DataAccess intForKey:K_REVERSE_MINUTE];
    if ( h == 0 && m == 0 )
    {
        m = 40;
        [DataAccess setInt:m forKey:K_REVERSE_MINUTE];
    }
    
    [DataAccess setBool:NO forKey:K_ENABLE_HISTORY];
    
	[DataAccess forseSync];
}

- (void)updateBackgroundColor:(UIColor *)color
{
	viewScoreKeeper.view.backgroundColor = color;
	viewMana.view.backgroundColor = color;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// per inizializzare l'app e prevedere aggiornamenti futuri
	BOOL init = [DataAccess boolForKey:kInit];
	if ( ! init ) 
		[self firstStart];
	else {
        // recupera la versione precedente
		NSString *oldVersion = [DataAccess objectForKey:kVersion];
        // recupera la versione attuale
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        if ( [oldVersion isKindOfClass:[NSString class]] )
        {
            if ( ! [oldVersion isEqualToString:currentVersion] )
            {
                [self updateCurrentVersion:currentVersion];
            }
        }
        else
        {
            [self updateCurrentVersion:currentVersion];
        }
			
	}
	
	rotated = NO;
	tabBarController = [[UITabBarController alloc] init];
	
	self.viewScoreKeeper = [[ViewScoreKeeper alloc] init];
	UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"ScoreKeeper", @"ScoreKeeper of the app") image:[UIImage imageNamed:@"blocco-notes.png"] tag:0];
	self.viewScoreKeeper.tabBarItem = item;
    /*self.viewScoreKeeper.storyPlayer1 = [NSMutableArray array];
    self.viewScoreKeeper.storyPlayer2 = [NSMutableArray array];*/
	[item release];
	
	viewMana = [[ViewMana alloc] init];
	item = [[UITabBarItem alloc] initWithTitle:@"Mana" image:[UIImage imageNamed:@"mana-symbol.png"] tag:1];
	viewMana.tabBarItem = item;
	[item release];
    self.viewScoreKeeper.viewMana = viewMana;
    
    viewAllSearch = [[ViewAllSearch alloc] initWithStyle:UITableViewStyleGrouped];
    item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
	viewAllSearch.tabBarItem = item;
	[item release];
    
    UINavigationController *nav = [[UINavigationController alloc] init];
    [nav pushViewController:viewAllSearch animated:NO];
    [viewAllSearch release];
    
    /*viewPlayersStatus = [[ViewPlayersStatus alloc] init];
    item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:3];
    viewPlayersStatus.tabBarItem = item;
    viewPlayersStatus.arrayPlayer1 = self.viewScoreKeeper.storyPlayer1;
    viewPlayersStatus.arrayPlayer2 = self.viewScoreKeeper.storyPlayer2;
    [item release];*/
    
    ViewGameHistory *vgh = [[ViewGameHistory alloc] initWithStyle:UITableViewStyleGrouped];
    item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:3];
    vgh.tabBarItem = item;
    [item release];
    UINavigationController *nav2 = [[UINavigationController alloc] init];
    [nav2 pushViewController:vgh animated:NO];
    [vgh release];
    	
	viewSettings = [[ViewSettings alloc] initWithStyle:UITableViewStyleGrouped];
	item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Settings", @"Setting of the app") image:[UIImage imageNamed:@"ingranaggio.png"] tag:4];
	viewSettings.tabBarItem = item;
	viewSettings.vsk = viewScoreKeeper;
	[item release];
    
    //ViewProvaCoreData *vpcd = [[ViewProvaCoreData alloc] init];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:self.viewScoreKeeper, viewMana, /*viewPlayersStatus,*/ nav2, nav, viewSettings, /*vpcd, */nil];
    //[vpcd release];
    [nav release];
    //[viewPlayersStatus release];
    [nav2 release];
    
    // Override point for customization after application launch.
	[window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    //NSLog(@"resign active");
    [viewScoreKeeper prepareToBackground];
	[DataAccess forseSync];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	
    //NSLog(@"enter background");
    /*[viewScoreKeeper prepareToBackground];
	[DataAccess forseSync];*/
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	//[viewScoreKeeper restoreFromBackground];
    //NSLog(@"enter foreground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */	
    //NSLog(@"become active");
    //[viewScoreKeeper restoreFromLockScreen];
    [viewScoreKeeper restoreFromBackground];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    //NSLog(@"will terminate");
}

// metodo delegate !
- (void)saveContextCoreData
{
    [self saveContext];
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"History" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"History.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[viewMana release];
    [viewAllSearch release];
	[viewSettings release];
	[tabBarController release];
	[viewScoreKeeper release];
    [window release];
    [super dealloc];
}


@end
