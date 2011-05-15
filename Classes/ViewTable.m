//
//  ViewTable.m
//  MTG Score
//
//  Created by Luca Bertani on 17/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewTable.h"


@implementation ViewTable

- (id)initInManagedObjectContext:(NSManagedObjectContext *)context
{
    if (( self = [super initWithStyle:UITableViewStyleGrouped] ))
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"GameHistory" inManagedObjectContext:context];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
        request.predicate = nil;
        request.fetchBatchSize = 20;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:@"MyGameHistory"];
        [request release];
        
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"timestamp";
        
    }
    
    return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    
}

@end
