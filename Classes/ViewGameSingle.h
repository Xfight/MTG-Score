//
//  ViewGameSingle.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"
#import "CoreDataTableViewController.h"

#import "ViewGameLineStatus.h"

@interface ViewGameSingle : CoreDataTableViewController {
    NSDateFormatter *dateFormat;
    GameHistory *gameHistory;
}

@property (nonatomic, retain) NSDateFormatter *dateFormat;
@property (nonatomic, retain) GameHistory *gameHistory;

@end
