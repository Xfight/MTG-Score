//
//  ViewGameHistoryDetails.h
//  MTG Score
//
//  Created by Luca Bertani on 20/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"
#import "ViewGameLineStatus.h"
#import "GameHistory.h"
#import "ObjectTableCell.h"

#define kTagWinner      1
#define kTagPlayerName  2
#define kTagPlayerDeck  3
#define kTagOpponentName 4
#define kTagOpponentDeck 5

@interface ViewGameHistoryDetails : UITableViewController<UITextFieldDelegate> {
    GameHistory *gameHistory;
    NSDateFormatter *dateFormat;
    NSString *cellDefault;
    NSString *cellDefaultClickable;
    NSString *cellEditable;
    
    NSMutableArray *arraySection;
    NSArray *arrayContainer;
}

@property (nonatomic, retain) GameHistory *gameHistory;
@property (nonatomic, retain) NSDateFormatter *dateFormat;
@property (nonatomic, retain) NSMutableArray *arraySection;
@property (nonatomic, retain) NSArray *arrayContainer;

@end
