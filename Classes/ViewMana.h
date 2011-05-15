//
//  ViewMana.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"

@interface ViewMana : UIViewController <UITextFieldDelegate> {
    UIInterfaceOrientation oldInterfaceOrientation;
    
	IBOutlet UIScrollView *scrollView;
	CGPoint svos;
	
	IBOutlet UIImageView *imageManaBlack;
	IBOutlet UIImageView *imageManaBlue;
	IBOutlet UIImageView *imageManaGreen;
	IBOutlet UIImageView *imageManaRed;
	IBOutlet UIImageView *imageManaWhite;
	IBOutlet UIImageView *imageManaColorless;
	
	int manaBlackInt;
	int manaBlueInt;
	int manaGreenInt;
	int manaRedInt;
	int manaWhiteInt;
	int manaColorlessInt;
	int textSpellCountInt;
	
	IBOutlet UITextField *manaBlackPool;
	IBOutlet UIButton *manaBlackPlus;
	IBOutlet UIButton *manaBlackMinus;
	IBOutlet UITextField *manaBluePool;
	IBOutlet UIButton *manaBluePlus;
	IBOutlet UIButton *manaBlueMinus;
	IBOutlet UITextField *manaGreenPool;
	IBOutlet UIButton *manaGreenPlus;
	IBOutlet UIButton *manaGreenMinus;
	IBOutlet UITextField *manaRedPool;
	IBOutlet UIButton *manaRedPlus;
	IBOutlet UIButton *manaRedMinus;
	IBOutlet UITextField *manaWhitePool;
	IBOutlet UIButton *manaWhitePlus;
	IBOutlet UIButton *manaWhiteMinus;
	IBOutlet UITextField *manaColorlessPool;
	IBOutlet UIButton *manaColorlessPlus;
	IBOutlet UIButton *manaColorlessMinus;
	
	IBOutlet UITextField *textSpell;
	IBOutlet UITextField *textSpellCount;
	IBOutlet UIButton *textSpellCountPlus;
	IBOutlet UIButton *textSpellCountMinus;
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) UIImageView *imageManaBlack;
@property (nonatomic, retain) UIImageView *imageManaBlue;
@property (nonatomic, retain) UIImageView *imageManaGreen;
@property (nonatomic, retain) UIImageView *imageManaRed;
@property (nonatomic, retain) UIImageView *imageManaWhite;
@property (nonatomic, retain) UIImageView *imageManaColorless;

@property (nonatomic, retain) UITextField *manaBlackPool;
@property (nonatomic, retain) UIButton *manaBlackPlus;
@property (nonatomic, retain) UIButton *manaBlackMinus;
@property (nonatomic, retain) UITextField *manaBluePool;
@property (nonatomic, retain) UIButton *manaBluePlus;
@property (nonatomic, retain) UIButton *manaBlueMinus;
@property (nonatomic, retain) UITextField *manaGreenPool;
@property (nonatomic, retain) UIButton *manaGreenPlus;
@property (nonatomic, retain) UIButton *manaGreenMinus;
@property (nonatomic, retain) UITextField *manaRedPool;
@property (nonatomic, retain) UIButton *manaRedPlus;
@property (nonatomic, retain) UIButton *manaRedMinus;
@property (nonatomic, retain) UITextField *manaWhitePool;
@property (nonatomic, retain) UIButton *manaWhitePlus;
@property (nonatomic, retain) UIButton *manaWhiteMinus;
@property (nonatomic, retain) UITextField *manaColorlessPool;
@property (nonatomic, retain) UIButton *manaColorlessPlus;
@property (nonatomic, retain) UIButton *manaColorlessMinus;

@property (nonatomic, retain) UITextField *textSpell;
@property (nonatomic, retain) UITextField *textSpellCount;
@property (nonatomic, retain) UIButton *textSpellCountPlus;
@property (nonatomic, retain) UIButton *textSpellCountMinus;

- (IBAction)checkInputInt:(id)sender;

- (IBAction)manaBlackAdd;
- (IBAction)manaBlackRemove;
- (IBAction)manaBlueAdd;
- (IBAction)manaBlueRemove;
- (IBAction)manaGreenAdd;
- (IBAction)manaGreenRemove;
- (IBAction)manaRedAdd;
- (IBAction)manaRedRemove;
- (IBAction)manaWhiteAdd;
- (IBAction)manaWhiteRemove;
- (IBAction)manaColorlessAdd;
- (IBAction)manaColorlessRemove;
- (IBAction)textSpellCountAdd;
- (IBAction)textSpellCountRemove;

- (IBAction)myResignFirstResponder;
- (void)resetAllMana;

@end
