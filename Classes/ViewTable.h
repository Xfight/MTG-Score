//
//  ViewTable.h
//  MTG Score
//
//  Created by Luca Bertani on 17/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"

@interface ViewTable : CoreDataTableViewController {
    NSManagedObjectContext *managedObjectContext;
}

//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initInManagedObjectContext:(NSManagedObjectContext *)context;

@end
