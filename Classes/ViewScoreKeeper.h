//
//  ViewScoreKeeper.h
//  MTG ScoreKeeper
//
//  Created by Luca on 18/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTimer.h"
#import "ViewDiceRoll.h"
#import "DataAccess.h"
#import "PlayerStatus.h"
#import "ViewPlayersStatus.h"

#import "ViewMana.h"

#import "iAd/iAd.h"
#import "AdViewController.h"

#import "GameKeeper.h"
#import "TableViewConfirmInsert.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define kTimerFire  1.5

#define kTimerStop   NSLocalizedString(@"Stop", @"Timer stop")
#define kTimerStart  NSLocalizedString(@"Start", @"Timer start")
#define kTimerResume NSLocalizedString(@"Resume", @"Timer resume")

#define kTitleEndGame       NSLocalizedString(@"End Game", @"End Game in ViewScoreKeeper")
#define kTitleResetGame     NSLocalizedString(@"Reset Game", @"Reset Game in ViewScoreKeeper")

#define kTitleStartMatch    NSLocalizedString(@"Start Match", @"Start Match in ViewScoreKeeper")
#define kTitleEndMatch      NSLocalizedString(@"End Match", @"End Match in ViewScoreKeeper")
#define kTitleResetTime     NSLocalizedString(@"Reset Time", @"Time reset in ViewScoreKeeper")

@interface ViewScoreKeeper : UIViewController <UIAlertViewDelegate, ADBannerViewDelegate, UIActionSheetDelegate, ConfirmInsertDelegate> {
		
	IBOutlet UITextField *poison;
	
	IBOutlet UITextField *namePlayer1;
	IBOutlet UITextField *scorePlayer1;
	IBOutlet UITextField *poisonPlayer1;
	int scorePlayer1Int;
	IBOutlet UIButton *player1Plus1;
	IBOutlet UIButton *player1Minus1;
	IBOutlet UIButton *player1Plus5;
	IBOutlet UIButton *player1Minus5;
	int poisonPlayer1Int;
	IBOutlet UIButton *player1PoisonPlus1;
	IBOutlet UIButton *player1PoisonMinus1;
	
	IBOutlet UITextField *namePlayer2;
	IBOutlet UITextField *scorePlayer2;
	IBOutlet UITextField *poisonPlayer2;
	int scorePlayer2Int;
	IBOutlet UIButton *player2Plus1;
	IBOutlet UIButton *player2Minus1;
	IBOutlet UIButton *player2Plus5;
	IBOutlet UIButton *player2Minus5;
	int poisonPlayer2Int;
	IBOutlet UIButton *player2PoisonPlus1;
	IBOutlet UIButton *player2PoisonMinus1;
	
    IBOutlet UIButton *buttonStopResumeTimer;
	IBOutlet UIButton *buttonDiceRoll;
	IBOutlet UIButton *buttonGameWin;
	IBOutlet UIButton *buttonStartEndMatch;
    NSDate *dateStartMatch;
    NSDate *dateStartGame;
	
	
	IBOutlet UILabel *labelNamedTimer;
	IBOutlet UILabel *labelTimer;
	MyTimer *timerClock;
    
    NSTimer *timerUpdateLife;
    NSMutableArray *storyPlayer1;
    NSMutableArray *storyPlayer2;
    BOOL waitAgain;
    
    ViewMana *viewMana;
    UIInterfaceOrientation oldInterfaceOrientation;
    
    /*UIView *_contentView;
    id _adBannerView;
    BOOL _adBannerViewIsVisible;*/
    ADBannerView *adView;
    BOOL bannerIsVisible;
    int failedBannerView;
    AdViewController *adMobViewController;
    IBOutlet UIButton *tmpButtonForAd;
}

@property (nonatomic, retain) IBOutlet ADBannerView *adView;
@property (nonatomic) BOOL bannerIsVisible;
@property (nonatomic, retain) AdViewController *adMobViewController;
@property (nonatomic, retain) IBOutlet UIButton *tmpButtonForAd;

/*@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;*/

@property (nonatomic, retain) ViewMana *viewMana;

@property (retain) NSTimer *timerUpdateLife;
@property (retain) NSMutableArray *storyPlayer1;
@property (retain) NSMutableArray *storyPlayer2;
@property BOOL waitAgain;

//@property (nonatomic, retain) UIInterfaceOrientation *oldInterfaceRotation;

@property (nonatomic, retain) UITextField *poison;

@property (nonatomic, retain) UITextField *namePlayer1;
@property (nonatomic, retain) UITextField *scorePlayer1;
@property (nonatomic, retain) UITextField *poisonPlayer1;
@property (nonatomic, retain) UIButton *player1Plus1;
@property (nonatomic, retain) UIButton *player1Minus1;
@property (nonatomic, retain) UIButton *player1Plus5;
@property (nonatomic, retain) UIButton *player1Minus5;
@property (nonatomic, retain) UIButton *player1PoisonPlus1;
@property (nonatomic, retain) UIButton *player1PoisonMinus1;

@property (nonatomic, retain) UITextField *namePlayer2;
@property (nonatomic, retain) UITextField *scorePlayer2;
@property (nonatomic, retain) UITextField *poisonPlayer2;
@property (nonatomic, retain) UIButton *player2Plus1;
@property (nonatomic, retain) UIButton *player2Minus1;
@property (nonatomic, retain) UIButton *player2Plus5;
@property (nonatomic, retain) UIButton *player2Minus5;
@property (nonatomic, retain) UIButton *player2PoisonPlus1;
@property (nonatomic, retain) UIButton *player2PoisonMinus1;

@property (nonatomic, retain) UIButton *buttonStopResumeTimer;
@property (nonatomic, retain) UIButton *buttonDiceRoll;
@property (nonatomic, retain) UIButton *buttonGameWin;
@property (nonatomic, retain) UIButton *buttonStartEndMatch;
@property (nonatomic, retain) UILabel *labelNamedTimer;
@property (nonatomic, retain) UILabel *labelTimer;
@property (nonatomic, retain) NSDate *dateStartGame;
@property (nonatomic, retain) NSDate *dateStartMatch;


- (IBAction)setPlayer1Plus1;
- (IBAction)setPlayer1Minus1;
- (IBAction)setPlayer1Plus5;
- (IBAction)setPlayer1Minus5;
- (IBAction)setPlayer1PoisonPlus1;
- (IBAction)setPlayer1PoisonMinus1;

- (IBAction)setPlayer2Plus1;
- (IBAction)setPlayer2Minus1;
- (IBAction)setPlayer2Plus5;
- (IBAction)setPlayer2Minus5;
- (IBAction)setPlayer2PoisonPlus1;
- (IBAction)setPlayer2PoisonMinus1;

- (IBAction)gameStatus;
- (IBAction)startStopTimer:(UIButton *)sender;
- (IBAction)gameWin;
- (IBAction)startEndMatch;
- (IBAction)diceRoll;
- (void)forceTimerUpdateLife;

- (IBAction)checkInputInt:(id)sender;
- (IBAction)restoreFirstResponder;
- (IBAction)savePlayer1;
- (IBAction)savePlayer2;


- (void)prepareToBackground;
- (void)restoreFromBackground;
- (void)restoreFromLockScreen;

- (void)readDatabaseFirstTime:(BOOL)firstTime;

@end
