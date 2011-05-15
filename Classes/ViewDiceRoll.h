//
//  ViewDiceRoll.h
//  MTG SK
//
//  Created by Luca on 21/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewDiceRoll : UIViewController {
	IBOutlet UIButton *dice1Roll;
	IBOutlet UILabel *dice1RollLabel;
	IBOutlet UIButton *dice2Roll;
	IBOutlet UILabel *dice2RollLabel;
}

@property (nonatomic, retain) UIButton *dice1Roll;
@property (nonatomic, retain) UILabel *dice1RollLabel;
@property (nonatomic, retain) UIButton *dice2Roll;
@property (nonatomic, retain) UILabel *dice2RollLabel;

- (IBAction)cancelButton;
- (IBAction)doneButton;

- (IBAction)rollDice1;
- (IBAction)rollDice2;
- (IBAction)resetDice;

@end
