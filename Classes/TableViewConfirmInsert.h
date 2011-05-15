//
//  TableViewConfirmInsert.h
//  MTG Score
//
//  Created by Luca on 20/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameKeeper.h"
#import "EditableTableCell.h"
#import "ObjectPair.h"

@class TableViewConfirmInsert;

@protocol ConfirmInsertDelegate <NSObject>
- (void)tableViewConfirmInsertDidFinishDisplay:(TableViewConfirmInsert *)vci resetGame:(BOOL)check;
@end


@interface TableViewConfirmInsert : UITableViewController <UITextFieldDelegate, UIActionSheetDelegate> {
    NSDate *dateStartMatch;
    NSString *namePlayer1;
    NSString *namePlayer2;
    
    NSMutableArray *arraySection;
    NSArray *arrayContainer;
    
    id<ConfirmInsertDelegate> delegate;
}

@property (nonatomic, retain) NSDate *dateStartMatch;
@property (nonatomic, copy) NSString *namePlayer1;
@property (nonatomic, copy) NSString *namePlayer2;

@property (nonatomic, retain) NSMutableArray *arraySection;
@property (nonatomic, retain) NSArray *arrayContainer;

@property (assign) id<ConfirmInsertDelegate> delegate;

- (IBAction)buttonWon;
- (IBAction)buttonDraw;
- (IBAction)buttonLoose;

- (IBAction)buttonCancel:(UIBarButtonItem *)sender;
- (IBAction)buttonSave:(UIBarButtonItem *)sender;

@end
