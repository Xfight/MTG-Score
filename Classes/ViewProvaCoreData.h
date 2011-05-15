//
//  ViewProvaCoreData.h
//  MTG Score
//
//  Created by Luca Bertani on 17/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

#import "GameHistory.h"
#import "GameLineStatus.h"

#import "ViewTable.h"


@interface ViewProvaCoreData : UIViewController {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (IBAction)buttonPress:(UIButton *)sender;
- (IBAction)buttonOpenView:(UIButton *)sender;
- (IBAction)buttonClean:(UIButton *)sender;


@end
