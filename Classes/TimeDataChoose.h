//
//  TimeDataChoose.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeDataEntryCell.h"
#import "RotatingDatePicker.h"

@interface TimeDataChoose : UIViewController {
	IBOutlet RotatingDatePicker *datePicker;
	IBOutlet UINavigationBar *navigationBar;
	id timeDataEntryCell;
	
	int timeSecond;
}

@property (nonatomic, retain) RotatingDatePicker *datePicker;
@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) id timeDataEntryCell;
@property int timeSecond;

- (IBAction)cancelButton;
- (IBAction)doneButton;

@end
