//
//  BaseDataEntryCell.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"


// Padding tra i controlli nella cella
#define LABEL_CONTROL_PADDING 5
// Padding del controllo rispetto al 
#define RIGHT_PADDING 5

// Nome della notifica di fine editing
#define CELL_ENDEDIT_NOTIFICATION_NAME @"CellEndEdit"

@interface BaseDataEntryCell : UITableViewCell {
	UIViewController *superViewController;
}

@property (nonatomic, retain) NSString *dataKey;
@property (nonatomic, retain) UIViewController *superViewController;

// Imposta il valore del controllo gestito (TextField, ...)
- (void)setControlValue:(id)value;

// Legge il valore dal controllo
- (id)getControlValue;

- (BOOL)getBooleanValue;

// Helper per l'invio della notifica di fine editing
- (void)postEndEditingNotification;

- (void)savePersistence;

@end
