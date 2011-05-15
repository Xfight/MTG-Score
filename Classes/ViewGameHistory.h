//
//  ViewGameHistory.h
//  MTG Score
//
//  Created by Luca Bertani on 21/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"

#import "ViewGameCurrent.h"
#import "ViewGameHistoryDetails.h"


@interface ViewGameHistory : UITableViewController <UIAlertViewDelegate> {
    NSDateFormatter *dateFormat;
    NSString *cellDefaultClickable;
    
    NSMutableArray *arraySection;
    NSArray *arrayContainer;
}

@property (nonatomic, retain) NSDateFormatter *dateFormat;
@property (nonatomic, retain) NSMutableArray *arraySection;
@property (nonatomic, retain) NSArray *arrayContainer;

@end
