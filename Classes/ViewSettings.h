//
//  ViewSettings.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "BaseDataEntryCell.h"
#import "TextDataEntryCell.h"
#import "SwitchDataEntryCell.h"
#import "TimeDataEntryCell.h"
#import "TimeDataChoose.h"
#import "ColorDataEntryCell.h"
#import "ViewScoreKeeper.h"
#import "ViewDiceRoll.h"

//@class MagicScoreKeeperAppDelegate;

@interface ViewSettings : UITableViewController {
	NSArray *tableStructure;
	NSMutableArray *tableData;
	ViewScoreKeeper *vsk;
}

@property (nonatomic, retain) ViewScoreKeeper *vsk;

@end
