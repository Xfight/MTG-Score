//
//  ViewScoreKeeper.m
//  MTG ScoreKeeper
//
//  Created by Luca on 18/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewScoreKeeper.h"

@interface ViewScoreKeeper()
- (void)viewRotation:(BOOL)animation;
- (void)updateColor;
@end

@implementation ViewScoreKeeper

@synthesize poison;

@synthesize namePlayer1, scorePlayer1, poisonPlayer1, player1Plus1, player1Minus1, player1Plus5, player1Minus5, player1PoisonPlus1, player1PoisonMinus1;
@synthesize namePlayer2, scorePlayer2, poisonPlayer2, player2Plus1, player2Minus1, player2Plus5, player2Minus5, player2PoisonPlus1, player2PoisonMinus1;

@synthesize labelNamedTimer, labelTimer, buttonStopResumeTimer, buttonDiceRoll, buttonGameWin, buttonStartEndMatch, dateStartGame, dateStartMatch;

@synthesize timerUpdateLife, storyPlayer1, storyPlayer2, waitAgain;

@synthesize viewMana;

@synthesize adView, bannerIsVisible, adMobViewController, tmpButtonForAd;

#pragma mark iAd

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    //NSLog(@"[iAd]: iAd Banner caricato.");
    //[tmpButtonForAd setTitle:@"iAd caricato" forState:UIControlStateNormal];
    
    failedBannerView = 0;
    
    if ( !self.bannerIsVisible )
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //NSLog(@"[iAd]: An action was started from the banner. Application will quit: %d", willLeave);
    //[tmpButtonForAd setTitle:@"iAd azione iniziata" forState:UIControlStateNormal];
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // Do nothings...
    // again !
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    /*NSLog(@"[iAd]: Impossibile caricare il banner. Errore : %@", error);
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"HH:MM:SS"];
    NSString* str = [formatter stringFromDate:date];
    
    [tmpButtonForAd setTitle:[NSString stringWithFormat:@"[%@] iAd errore !!", str]
                    forState:UIControlStateNormal];*/
    failedBannerView++;
    
    if ( failedBannerView >= 3 )
    {
        self.bannerIsVisible = false;
        [self.adView removeFromSuperview];
        self.adView.delegate = nil;
        self.adView = nil;
        
        
        if (adMobViewController != nil)
            self.adMobViewController = nil;
        
        adMobViewController = [[AdViewController alloc] init];
        adMobViewController.view.frame = CGRectMake(0, 363, 320, 48);
        adMobViewController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        adMobViewController.currentViewController = self;
        [self.view addSubview:adMobViewController.view];
        
        [self updateColor];
        
        [adMobViewController awakeFromNib];
    }
    
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        //banner.frame = CGRectOffset(banner.frame, 0, 50);
        self.adView.frame = CGRectOffset(self.adView.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = false;
    }
}


#pragma mark Gestione punti vari

- (void)updateStoryLife
{
    if ( ! self.waitAgain )
    {
        [self.storyPlayer1 addObject:[PlayerStatus playerStatusLife:scorePlayer1Int andInfect:poisonPlayer1Int]];
        [self.storyPlayer2 addObject:[PlayerStatus playerStatusLife:scorePlayer2Int andInfect:poisonPlayer2Int]];
        
        //NSLog(@"p1 : %@", self.storyPlayer1);
        [self.timerUpdateLife invalidate];
        self.timerUpdateLife = nil;
    } else
    {
        self.waitAgain = NO;
    }
}

- (void)timerClean
{
    if ( self.timerUpdateLife != nil )
    {
        [self.timerUpdateLife invalidate];
        self.timerUpdateLife = nil;
    }
    
    self.storyPlayer1 = [NSMutableArray array];
    [self.storyPlayer1 addObject:[PlayerStatus playerStatusLife:scorePlayer1Int andInfect:poisonPlayer1Int]];
    self.storyPlayer2 = [NSMutableArray array];
    [self.storyPlayer2 addObject:[PlayerStatus playerStatusLife:scorePlayer2Int andInfect:poisonPlayer2Int]];
    
    /*[self.storyPlayer1 removeAllObjects];
    [self.storyPlayer1 addObject:[PlayerStatus playerStatusLife:scorePlayer1Int andInfect:poisonPlayer1Int]];
    [self.storyPlayer2 removeAllObjects];
    [self.storyPlayer2 addObject:[PlayerStatus playerStatusLife:scorePlayer2Int andInfect:poisonPlayer2Int]];*/
}

- (void)goTimerUpdateLife
{
    if ( self.timerUpdateLife == nil )
    {
        self.timerUpdateLife = [NSTimer scheduledTimerWithTimeInterval:kTimerFire target:self selector:@selector(updateStoryLife) userInfo:nil repeats:YES];
    }
    else
        self.waitAgain = YES;
}

- (IBAction)setPlayer1Plus1 {
	if ( ! (scorePlayer1Int == INT_MAX) )
    {
        [self goTimerUpdateLife];
		scorePlayer1.text = [NSString stringWithFormat:@"%d", ++scorePlayer1Int];
    }
}
- (IBAction)setPlayer1Minus1 {
	if ( ! (scorePlayer1Int == INT_MIN) )
    {
		scorePlayer1.text = [NSString stringWithFormat:@"%d", --scorePlayer1Int];
        [self goTimerUpdateLife];
    }
}
- (IBAction)setPlayer1Plus5 {
	if ( scorePlayer1Int <= INT_MAX - 5 ) {
        [self goTimerUpdateLife];
		scorePlayer1Int += 5;
		scorePlayer1.text = [NSString stringWithFormat:@"%d", scorePlayer1Int];
	}
}
- (IBAction)setPlayer1Minus5 {
	if ( scorePlayer1Int >= INT_MIN + 5 ) {
        [self goTimerUpdateLife];
		scorePlayer1Int -= 5;
		scorePlayer1.text = [NSString stringWithFormat:@"%d", scorePlayer1Int];
	}
}
- (IBAction)setPlayer1PoisonPlus1 {
	if ( ! (poisonPlayer1Int == INT_MAX) )
    {
        [self goTimerUpdateLife];
		poisonPlayer1.text = [NSString stringWithFormat:@"%d", ++poisonPlayer1Int];
    }
}
- (IBAction)setPlayer1PoisonMinus1 {
	if ( poisonPlayer1Int > 0 )
    {
        [self goTimerUpdateLife];
		poisonPlayer1.text = [NSString stringWithFormat:@"%d", --poisonPlayer1Int];
    }
}

- (IBAction)setPlayer2Plus1 {
	if ( ! (scorePlayer2Int == INT_MAX) )
    {
        [self goTimerUpdateLife];
		scorePlayer2.text = [NSString stringWithFormat:@"%d", ++scorePlayer2Int];
    }
}
- (IBAction)setPlayer2Minus1 {
	if ( ! (scorePlayer2Int == INT_MIN) )
    {
        [self goTimerUpdateLife];
		scorePlayer2.text = [NSString stringWithFormat:@"%d", --scorePlayer2Int];
    }
}
- (IBAction)setPlayer2Plus5 {
	if ( scorePlayer2Int <= INT_MAX - 5 ) {
        [self goTimerUpdateLife];
		scorePlayer2Int += 5;
		scorePlayer2.text = [NSString stringWithFormat:@"%d", scorePlayer2Int];
	}
}
- (IBAction)setPlayer2Minus5 {
	if ( scorePlayer1Int >= INT_MIN + 5 ) {
        [self goTimerUpdateLife];
		scorePlayer2Int -= 5;
		scorePlayer2.text = [NSString stringWithFormat:@"%d", scorePlayer2Int];
	}
}
- (IBAction)setPlayer2PoisonPlus1 {
	if ( ! (poisonPlayer2Int == INT_MAX) )
    {
        [self goTimerUpdateLife];
		poisonPlayer2.text = [NSString stringWithFormat:@"%d", ++poisonPlayer2Int];
    }
}
- (IBAction)setPlayer2PoisonMinus1 {
	if ( [poisonPlayer2.text intValue] > 0 )
    {
        [self goTimerUpdateLife];
		poisonPlayer2.text = [NSString stringWithFormat:@"%d", --poisonPlayer2Int];
    }
}


- (void)buttonHide:(BOOL)hide
{
    if ( hide )
    {
        poison.hidden = YES;
        
        namePlayer1.hidden = YES;
        scorePlayer1.hidden = YES;
        poisonPlayer1.hidden = YES;
        player1Plus1.hidden = YES;
        player1Minus1.hidden = YES;
        player1Plus5.hidden = YES;
        player1Minus5.hidden = YES;
        player1PoisonPlus1.hidden = YES;
        player1PoisonMinus1.hidden = YES;
        
        namePlayer2.hidden = YES;
        scorePlayer2.hidden = YES;
        poisonPlayer2.hidden = YES;
        player2Plus1.hidden = YES;
        player2Minus1.hidden = YES;
        player2Plus5.hidden = YES;
        player2Minus5.hidden = YES;
        player2PoisonPlus1.hidden = YES;
        player2PoisonMinus1.hidden = YES;
        
        buttonStopResumeTimer.hidden = YES;
        buttonDiceRoll.hidden = YES;
        buttonGameWin.hidden = YES;
        //buttonStartEndMatch.hidden = YES;
        labelNamedTimer.hidden = YES;
        labelTimer.hidden = YES;
    }
    else
    {
        poison.hidden = NO;
        
        namePlayer1.hidden = NO;
        scorePlayer1.hidden = NO;
        poisonPlayer1.hidden = NO;
        player1Plus1.hidden = NO;
        player1Minus1.hidden = NO;
        player1Plus5.hidden = NO;
        player1Minus5.hidden = NO;
        player1PoisonPlus1.hidden = NO;
        player1PoisonMinus1.hidden = NO;
        
        namePlayer2.hidden = NO;
        scorePlayer2.hidden = NO;
        poisonPlayer2.hidden = NO;
        player2Plus1.hidden = NO;
        player2Minus1.hidden = NO;
        player2Plus5.hidden = NO;
        player2Minus5.hidden = NO;
        player2PoisonPlus1.hidden = NO;
        player2PoisonMinus1.hidden = NO;
        
        buttonStopResumeTimer.hidden = NO;
        buttonDiceRoll.hidden = NO;
        buttonGameWin.hidden = NO;
        buttonStartEndMatch.hidden = NO;
        labelNamedTimer.hidden = NO;
        labelTimer.hidden = NO;
    }
}

#pragma mark Gestione altri pulsanti

- (void)initializeStartMatch
{
    /*self.buttonStopResumeTimer.hidden = YES;
    self.buttonGameWin.hidden = YES;*/
    [self.buttonStartEndMatch setTitle:kTitleStartMatch forState:UIControlStateNormal];
    
    [timerClock stopTimerAndReset];
    if ( dateStartGame != nil ) self.dateStartGame = nil;
    if ( dateStartMatch != nil ) self.dateStartMatch = nil;
    
    [self buttonHide:YES];
    
    /*if ( UIDeviceOrientationIsLandscape(self.interfaceOrientation) )
    {
        buttonStartEndMatch.frame = CGRectMake(165, 175, 150, 37);
    }
    else
    {
        buttonStartEndMatch.frame =  CGRectMake(106, 284, 107, 37);
    }*/
}

- (void)initializeEndMatch
{
    //if ( ! [timerClock isEnabled] )
    //    [timerClock startTimer];
    
    if ( [timerClock isEnabled] )
        [buttonStopResumeTimer setTitle:kTimerStop forState:UIControlStateNormal];
    
    self.dateStartGame = [NSDate date];
    self.dateStartMatch = [NSDate date];
    [self buttonHide:NO];
    /*self.buttonStopResumeTimer.hidden = NO;
    self.buttonGameWin.hidden = NO;*/
    [self viewRotation:YES];
}

- (void)gameReset
{
    scorePlayer1.text = [NSString stringWithFormat:@"%d", 20];
    scorePlayer2.text = [NSString stringWithFormat:@"%d", 20];
    poisonPlayer1.text = [NSString stringWithFormat:@"%d", 0]; 
    poisonPlayer2.text = [NSString stringWithFormat:@"%d", 0];
    scorePlayer1Int = 20;
    scorePlayer2Int = 20;
    poisonPlayer1Int = 0;
    poisonPlayer2Int = 0;
    
    self.dateStartGame = [NSDate date];
    
    [self timerClean];
    [self.viewMana resetAllMana];
}

- (void)forceTimerUpdateLife
{
    if ( self.timerUpdateLife != nil )
    {
        self.waitAgain = NO;
        [self.timerUpdateLife fire];
        [self.timerUpdateLife invalidate];
        self.timerUpdateLife = nil;
    }
}

- (IBAction)gameStatus
{
    /*if ( self.timerUpdateLife != nil )
    {
        self.waitAgain = NO;
        [self.timerUpdateLife fire];
        [self.timerUpdateLife invalidate];
        self.timerUpdateLife = nil;
    }*/
    [self forceTimerUpdateLife];
    
    ViewPlayersStatus *vps = [[ViewPlayersStatus alloc] init];
    vps.arrayPlayer1 = storyPlayer1;
    vps.player1Name = namePlayer1.text;
    vps.arrayPlayer2 = storyPlayer2;
    vps.player2Name = namePlayer2.text;
    [self presentModalViewController:vps animated:YES];
    [vps release];
}

- (IBAction)startStopTimer:(UIButton *)sender
{
    if ( [[sender titleForState:UIControlStateNormal]  isEqualToString:kTimerStop] )
    {
        [timerClock stopTimer];
        [sender setTitle:kTimerResume forState:UIControlStateNormal];
        [timerClock freezeTimer];
    }
    else if ( [[sender titleForState:UIControlStateNormal] isEqualToString:kTimerStart] )
    {
        [sender setTitle:kTimerStop forState:UIControlStateNormal];
        [timerClock startOnlyTimer];
    }
    else if ( [[sender titleForState:UIControlStateNormal] isEqualToString:kTimerResume] )
    {
        [timerClock resumeTimer:NO];
        [timerClock startOnlyTimer];
        [sender setTitle:kTimerStop forState:UIControlStateNormal];
    }
}

- (IBAction)diceRoll {
	ViewDiceRoll *vdr = [[ViewDiceRoll alloc] init];
	vdr.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[self presentModalViewController:vdr animated:YES];
	
	[vdr release];
}

- (IBAction)gameWin {
    
    if ( [[buttonGameWin titleForState:UIControlStateNormal] isEqualToString:kTitleEndGame] )
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:NSLocalizedString(@"Game result", @"Game result on ViewScoreKeeper")
                                      delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                      destructiveButtonTitle:NSLocalizedString(@"I won", @"I won on ViewScoreKeeper")
                                      otherButtonTitles:NSLocalizedString(@"I lost", @"I lost on ViewScoreKeeper"), NSLocalizedString(@"Draw", @"Draw result") , nil];
        actionSheet.tag = 1;
        //[actionSheet showInView:self.view];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
        [actionSheet release];
    }
    else // case kTitleResetGame
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm game reset", @"Dialog for reset game with 2 button, confirm or abort") message:NSLocalizedString(@"Are you sure ?", @"Title of dialog for reset game/time") delegate:self cancelButtonTitle:NSLocalizedString(@"No", @"No, simple") otherButtonTitles:NSLocalizedString(@"Yes", @"Yes, simple"), nil];
        [alert show];
        [alert release];
    }
    
    /*
    if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleStartMatch] )
    { // se non ho fatto partire il match, resetto il gioco
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm game reset", @"Dialog for reset game with 2 button, confirm or abort") message:NSLocalizedString(@"Are you sure ?", @"Title of dialog for reset game/time") delegate:self cancelButtonTitle:NSLocalizedString(@"No", @"No, simple") otherButtonTitles:NSLocalizedString(@"Yes", @"Yes, simple"), nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:NSLocalizedString(@"Game result", @"Game result on ViewScoreKeeper")
                                      delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                      destructiveButtonTitle:NSLocalizedString(@"I won", @"I won on ViewScoreKeeper")
                                      otherButtonTitles:NSLocalizedString(@"I lost", @"I lost on ViewScoreKeeper"), NSLocalizedString(@"Draw", @"Draw result") , nil];
        actionSheet.tag = 1;
        //[actionSheet showInView:self.view];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
        [actionSheet release];
    }
     */
}

- (void)tableViewConfirmInsertDidFinishDisplay:(TableViewConfirmInsert *)tvci resetGame:(BOOL)check
{
    [tvci dismissModalViewControllerAnimated:YES];
    
    if ( check ) 
    {
        [self gameReset];
        [self initializeStartMatch];
        [buttonStartEndMatch setTitle:kTitleStartMatch forState:UIControlStateNormal];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ( actionSheet.tag == 1 )
    {
        if ( buttonIndex != 3 ) // ! "Cancel"
            [self forceTimerUpdateLife];
        
        if ( buttonIndex == 0 ) // "I win"
        {
            [[GameKeeper sharedGameKeeper] insertGameOutcome:kGameResultWin storyPlayer1:self.storyPlayer1 storyPlayer2:self.storyPlayer2 timestamp:dateStartGame];
        }
        else if ( buttonIndex == 1 ) // "I lost"
        {
            [[GameKeeper sharedGameKeeper] insertGameOutcome:kGameResultLost storyPlayer1:self.storyPlayer1 storyPlayer2:self.storyPlayer2 timestamp:dateStartGame];
        }
        else if ( buttonIndex == 2 ) // "Draw"
        {
            [[GameKeeper sharedGameKeeper] insertGameOutcome:kGameResultDraw storyPlayer1:self.storyPlayer1 storyPlayer2:self.storyPlayer2 timestamp:dateStartGame];
        }
        
        if ( buttonIndex != 3 ) // ! "Cancel"
            [self gameReset];
    }
    else if ( actionSheet.tag == 2 )
    {
        if ( buttonIndex == 0 ) // Yes, save
        {
            TableViewConfirmInsert *tvci = [[TableViewConfirmInsert alloc] initWithStyle:UITableViewStyleGrouped];
            tvci.namePlayer1 = self.namePlayer1.text;
            tvci.namePlayer2 = self.namePlayer2.text;
            tvci.dateStartMatch = self.dateStartMatch;
            tvci.delegate = self;
            
            UINavigationController *nav = [[UINavigationController alloc] init];
            [nav pushViewController:tvci animated:NO];
            [self presentModalViewController:nav animated:YES];
            [tvci release];
            [nav release];
        }
        else if ( buttonIndex == 1 ) // Yes, discard
        {
            [[GameKeeper sharedGameKeeper] clean];
            [self gameReset];
            [self initializeStartMatch];
            [buttonStartEndMatch setTitle:kTitleStartMatch forState:UIControlStateNormal];
        }
        
    }
}

- (IBAction)startEndMatch {
	if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleStartMatch] )
    {
        [buttonStartEndMatch setTitle:kTitleEndMatch forState:UIControlStateNormal];
        if ( ![timerClock isEnabled] )
            [timerClock startTimer];
        [self initializeEndMatch];
    }
    else if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleEndMatch] )  // caso end match
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:NSLocalizedString(@"End match ?", @"End match ? on ViewScoreKeeper")
                                      delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"Keep playing", @"Keep playing on ViewScoreKeeper")
                                      destructiveButtonTitle:NSLocalizedString(@"Yes (Save result)", @"Yes (Save result) on ViewScoreKeeper")
                                      otherButtonTitles:NSLocalizedString(@"Yes (Don't save)", @"Yes (Don't save) on ViewScoreKeeper"), nil];
        actionSheet.tag = 2;
        //[actionSheet showInView:self.view];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
        [actionSheet release];
    } else if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleResetTime] )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm timer reset", @"Dialog for reset timer with 2 button, confirm or abort") message:NSLocalizedString(@"Are you sure ?", @"Title of dialog for reset game/time") delegate:self cancelButtonTitle:NSLocalizedString(@"No", @"No, simple") otherButtonTitles:NSLocalizedString(@"Yes", @"Yes, simple"), nil];
        [alert show];
        [alert release];
    }
}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != [alertView cancelButtonIndex]) {
		if ([alertView.title isEqualToString:NSLocalizedString(@"Confirm game reset", @"Dialog for reset game with 2 button, confirm or abort")]) {
			scorePlayer1.text = [NSString stringWithFormat:@"%d", 20];
			scorePlayer2.text = [NSString stringWithFormat:@"%d", 20];
			poisonPlayer1.text = [NSString stringWithFormat:@"%d", 0]; 
			poisonPlayer2.text = [NSString stringWithFormat:@"%d", 0];
			scorePlayer1Int = 20;
			scorePlayer2Int = 20;
			poisonPlayer1Int = 0;
			poisonPlayer2Int = 0;
            
            [self timerClean];
            [self.viewMana resetAllMana];
			
		} else if ([alertView.title isEqualToString:NSLocalizedString(@"Confirm timer reset", @"Dialog for reset timer with 2 button, confirm or abort")]) {
			BOOL t = [DataAccess boolForKey:K_ENABLE_TIMER];
			if ( t )
            {
				//[timerClock startTimer];
                [timerClock stopTimerAndReset];
                [buttonStopResumeTimer setTitle:kTimerStart forState:UIControlStateNormal];
            }
			else 
            {
				[timerClock stopTimerAndReset];
                [buttonStopResumeTimer setTitle:kTimerStart forState:UIControlStateNormal];
            }
		}
	}
}

#pragma mark Gestione input UITextField
- (IBAction)checkInputInt:(id)sender {
	UITextField *textField1 = (UITextField *) sender;
	
	int a;
	BOOL check = [[NSScanner scannerWithString:textField1.text] scanInt:&a];
	
	if ( check ) {
		
		// 3 casi
		// 1. ho un numero
		// 2. ho numeri ed un carattere
		// 3. ho un overflow
		
		// caso 1. e 2. e 3. (grazie al confronto fra stringhe)
		if ( ! [textField1.text isEqualToString:[NSString stringWithFormat:@"%d", a]] ) {
			textField1.text = [NSString stringWithFormat:@"%d", a];
		}
		
		switch ([sender tag]) {
			case 1: scorePlayer1Int = a; break;
			case 2: scorePlayer2Int = a; break;
			case 3:
				if ( a < 0 ) {
					poisonPlayer1Int = 0;
					textField1.text = @"0";
				} else 
					poisonPlayer1Int = a;
				break;
			case 4:
				if ( a < 0 ) {
					poisonPlayer2Int = 0;
					textField1.text = @"0";
				} else 
					poisonPlayer2Int = a;
				break;
			default: break;
		}
		
	} else {
		// ho solo caratteri illegibili
		// se la stringa non e' vuota (cosa ammessa), ripulisco il testo
		if ( ! [textField1.text isEqualToString:@""] ) {
			textField1.text = @"";
			// ed azzero il contatore dei punti vita (temporaneamente)
		}
		
		switch ([sender tag]) {
			case 1: scorePlayer1Int = 0; break;
			case 2: scorePlayer2Int = 0; break;
			case 3: poisonPlayer1Int = 0; break;
			case 4: poisonPlayer2Int = 0; break;
			default: break;
		}
	}
}

- (IBAction)restoreFirstResponder {
	[DataAccess setObject:namePlayer1.text forKey:kPlayer1];
	[DataAccess setObject:namePlayer2.text forKey:kPlayer2];
	[DataAccess setObject:poison.text forKey:K_POISON];
	
	[namePlayer1 resignFirstResponder];
	[scorePlayer1 resignFirstResponder];
	
	[namePlayer2 resignFirstResponder];
	[scorePlayer2 resignFirstResponder];
	
	[poison resignFirstResponder];
	[poisonPlayer1 resignFirstResponder];
	[poisonPlayer2 resignFirstResponder];
	
	
	
	if ( [[NSScanner scannerWithString:scorePlayer1.text] scanInt:nil] )
		scorePlayer1Int = [scorePlayer1.text intValue];
	else
		scorePlayer1.text = [NSString stringWithFormat:@"%d", scorePlayer1Int];
	
	if ( [[NSScanner scannerWithString:scorePlayer2.text] scanInt:nil] )
		scorePlayer2Int = [scorePlayer2.text intValue];
	else
		scorePlayer2.text = [NSString stringWithFormat:@"%d", scorePlayer2Int];
    
    [DataAccess forseSync];
}

- (IBAction)savePlayer1 {
	[DataAccess setObject:namePlayer1.text forKey:kPlayer1];
	[namePlayer1 resignFirstResponder];
    [DataAccess forseSync];
}
- (IBAction)savePlayer2 {
	[DataAccess setObject:namePlayer2.text forKey:kPlayer2];
	[namePlayer2 resignFirstResponder];
    [DataAccess forseSync];
}


#pragma mark Gestione timerClock

- (void)prepareToBackground
{
	[timerClock freezeTimer];
}

- (void)restoreFromBackground
{
	BOOL enableTimer = [DataAccess boolForKey:K_ENABLE_TIMER];
    
    if ( [[buttonStopResumeTimer titleForState:UIControlStateNormal] isEqualToString:kTimerStop] )
        [timerClock resumeTimer:YES];
    else
        [timerClock resumeTimer:NO];
	
	if ( enableTimer ) {
		[timerClock timerRefresh];
        if ( [[buttonStopResumeTimer titleForState:UIControlStateNormal] isEqualToString:kTimerStop] )
            [timerClock startOnlyTimer];
	} else {
		[timerClock stopTimerAndReset];
	}
}

- (void)restoreFromLockScreen
{
    BOOL enableTimer = [DataAccess boolForKey:K_ENABLE_TIMER];
    
    //[timerClock resumeTimerFromLockScreen];
    
    if ( enableTimer )
    {
        [timerClock timerRefresh];
		[timerClock startOnlyTimer];
	} else {
		[timerClock stopTimerAndReset];
	}
}

- (void)myTimerAlarmOnEndTime:(MyTimer *)timer
{
    [timerClock stopTimer];
}

#pragma mark Gestione ViewScoreKeeper

- (void)updateColor
{
	UIColor *c = [DataAccess colorForKey:K_BACKGROUND_COLOR];
	self.view.backgroundColor = c;
		
	c = [DataAccess colorForKey:K_TEXT_TIMER_COLOR];
	labelTimer.textColor = c;
	labelNamedTimer.textColor = c;
    
    if (self.adMobViewController != nil)
        self.adMobViewController.view.backgroundColor = c;

}

- (void)readDatabaseFirstTime:(BOOL)firstTime
{
	// metodo da implementare per leggere tutti i valori utili
	
	BOOL reverseTimer = [DataAccess boolForKey:K_REVERSE_COUNT_TIME];
	
	int h,m,s;
	
	//if ( reverseTimer ) {
		h = [DataAccess intForKey:K_REVERSE_HOUR];
		m = [DataAccess intForKey:K_REVERSE_MINUTE];
		s = [DataAccess intForKey:K_REVERSE_SECOND];
	//}
	
	BOOL alarmOnTen = [DataAccess boolForKey:K_ALARM_ON_TEN_MINUTES];
	BOOL alarmOnEnd = [DataAccess boolForKey:K_ALARM_ON_END_TIME];
	
	BOOL enableTimer = [DataAccess boolForKey:K_ENABLE_TIMER];
	
	if ( enableTimer ) {
		//[timerClock stopTimer];
		
		labelTimer.hidden = NO;
		labelNamedTimer.hidden = NO;
        buttonStartEndMatch.hidden = NO;
        
		
		[timerClock setReverseTimerWithHours:h minutes:m seconds:s];
		timerClock.reverseTimer = reverseTimer;
		timerClock.alarmOnEndTime = alarmOnEnd;
		timerClock.alarmOnTenMinutes = alarmOnTen;
		
		[timerClock timerRefresh];
        
        buttonStopResumeTimer.hidden = NO;
        if ( [buttonStopResumeTimer.titleLabel.text isEqualToString:kTimerStop] )
        {
            [timerClock startOnlyTimer];
        }
        else
        {
            [timerClock stopTimerAndReset];
        }
        
		//[timerClock startOnlyTimer];
	} else {
		labelTimer.hidden = YES;
		labelNamedTimer.hidden = YES;
        buttonStartEndMatch.hidden = YES;

        buttonStopResumeTimer.hidden = YES;
		[timerClock stopTimerAndReset];
	}
	
	BOOL b = [DataAccess boolForKey:K_DISPLAY_SLEEP];
	if ( b )
		[UIApplication sharedApplication].idleTimerDisabled = YES;
	else
		[UIApplication sharedApplication].idleTimerDisabled = NO;
	
	NSString *str = [DataAccess objectForKey:kLanguageApp];
    
    if ( [str isEqualToString:kLanguageAutomatic] )
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppleLanguages"];
    else {
        [[NSUserDefaults standardUserDefaults] setObject: [NSArray arrayWithObjects:str, nil] forKey:@"AppleLanguages"];
    }
    
    b = [DataAccess boolForKey:K_ENABLE_HISTORY];
    
    if ( b )
    {
        //[self buttonHide:YES];
        if ( firstTime )
        {
            [self gameReset];
            [buttonStartEndMatch setTitle:kTitleStartMatch forState:UIControlStateNormal];
            [self initializeStartMatch];
        }
        else
        {
            [buttonStartEndMatch setTitle:kTitleEndMatch forState:UIControlStateNormal];
            [self initializeEndMatch];
        }
        
        [buttonGameWin setTitle:kTitleEndGame forState:UIControlStateNormal];
    }
    else
    {
        [self buttonHide:NO];
        [buttonStartEndMatch setTitle:kTitleResetTime forState:UIControlStateNormal];
        [buttonGameWin setTitle:kTitleResetGame forState:UIControlStateNormal];
    }

	
	[self updateColor];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    oldInterfaceOrientation = UIInterfaceOrientationPortrait;//[[UIApplication sharedApplication] statusBarOrientation];
	
	namePlayer1.text = [DataAccess objectForKey:kPlayer1];
	namePlayer2.text = [DataAccess objectForKey:kPlayer2];
	
	scorePlayer1.text = [NSString stringWithFormat:@"%d", 20];
	scorePlayer2.text = [NSString stringWithFormat:@"%d", 20];
	scorePlayer1Int = 20;
	scorePlayer2Int = 20;
	poisonPlayer1.text = [NSString stringWithFormat:@"%d", 0]; 
	poisonPlayer2.text = [NSString stringWithFormat:@"%d", 0];
	poisonPlayer1Int = 0;
	poisonPlayer2Int = 0;
	
	BOOL b = [DataAccess boolForKey:K_DISPLAY_SLEEP];
	if ( b )
		[UIApplication sharedApplication].idleTimerDisabled = YES;
	else
		[UIApplication sharedApplication].idleTimerDisabled = NO;
	
	if ( timerClock == nil )
    {
		timerClock = [[MyTimer alloc] initWithLabel:labelTimer];
    }
	
	// il timer viene lanciato se nel database e' abilitato
	[self readDatabaseFirstTime:YES];
    [timerClock stopTimerAndReset];
    
    
    self.storyPlayer1 = [NSMutableArray array];
    self.storyPlayer2 = [NSMutableArray array];
    self.timerUpdateLife = nil;
    self.waitAgain = NO;
    
    [self.storyPlayer1 addObject:[PlayerStatus playerStatusLife:scorePlayer1Int andInfect:poisonPlayer1Int]];
    [self.storyPlayer2 addObject:[PlayerStatus playerStatusLife:scorePlayer2Int andInfect:poisonPlayer2Int]];
    
    // inizializza banner
    failedBannerView = 0;
    adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 411, 0, 0)];
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    
    /*
     ADBannerContentSizeIdentifier320x50 sara' anche deprecato, ma almeno non fa crashare l'app usando iOS 4.1 :)
     */
    //adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:adView];
    self.adView.delegate = self;
    self.bannerIsVisible = NO;
    
    // sistema la grafica
    //[self initializeStartMatch];
    [self viewRotation:NO];
	
    [super viewDidLoad];
}

- (void)viewRotation:(BOOL)animation
{
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
    if (animation) {
        [UIView beginAnimations: @"anim2" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
    }
	
	if (UIDeviceOrientationIsLandscape(toOrientation)) {
        
        /*labelNamedTimer.frame =   CGRectMake(219, 89, 44, 21);
		labelTimer.frame =       CGRectMake(207, 113, 67, 21);
		buttonDiceRoll.frame  =  CGRectMake(205, 45, 72, 36);
		buttonResetGame.frame =  CGRectMake(170, 150, 150, 37);
		buttonResetTimer.frame = CGRectMake(170, 195, 150, 37);
        
        buttonStopResumeTimer.frame  =  CGRectMake(204, 124, 72, 30);*/
        
        labelNamedTimer.frame =  CGRectMake(218, 78, 44, 21);
		labelTimer.frame =       CGRectMake(206, 98, 67, 21);
        buttonStopResumeTimer.frame  =  CGRectMake(204, 124, 72, 30);
		buttonDiceRoll.frame  =  CGRectMake(204, 44, 72, 30);
		buttonGameWin.frame =  CGRectMake(165, 162, 150, 37);
        
        /*if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleStartMatch] )
            buttonStartEndMatch.frame = CGRectMake(165, 175, 150, 37);
        else*/
            buttonStartEndMatch.frame = CGRectMake(165, 205, 150, 37);
        
		
        namePlayer1.frame  = CGRectMake(13, 5, 97, 31);
        scorePlayer1.frame = CGRectMake(13, 37, 97, 57);
		poisonPlayer1.frame = CGRectMake(135, 5, 42, 31);
		player1PoisonPlus1.frame = CGRectMake(135, 48, 42, 35);
		player1PoisonMinus1.frame = CGRectMake(135, 95, 42, 35);
		player1Plus1.frame  = CGRectMake(13, 102, 97, 42);
		player1Minus1.frame = CGRectMake(13, 152, 97, 42);
		player1Plus5.frame  = CGRectMake(13, 202, 46, 42);
		player1Minus5.frame = CGRectMake(64,202, 46, 42);
		
        namePlayer2.frame  = CGRectMake(369, 5, 97, 31);
        scorePlayer2.frame = CGRectMake(369, 37, 97, 57);
		poisonPlayer2.frame = CGRectMake(302, 5, 42, 31);
		player2PoisonPlus1.frame = CGRectMake(302, 48, 42, 35);
		player2PoisonMinus1.frame = CGRectMake(302, 95, 42, 35);
		player2Plus1.frame  = CGRectMake(369, 102, 97, 42);
		player2Minus1.frame = CGRectMake(369, 152, 97, 42);
		player2Plus5.frame  = CGRectMake(369, 202, 46, 42);
		player2Minus5.frame = CGRectMake(420, 202, 46, 42);
        
        /*if ( self.view.frame.size.height != 251 )
            self.view.frame = CGRectMake(0, 0, 480, 251);*/
        if ( self.adMobViewController != nil )
            [self.adMobViewController.view setHidden:YES];
		
	} else {
        
        labelNamedTimer.frame =   CGRectMake(102, 160, 44, 21);
		labelTimer.frame =        CGRectMake(151, 160, 67, 21);
		buttonDiceRoll.frame  =   CGRectMake(123, 228, 72, 30);
		buttonGameWin.frame =   CGRectMake(106, 269, 107, 37);
        
        /*if ( [[buttonStartEndMatch titleForState:UIControlStateNormal] isEqualToString:kTitleStartMatch] )
            buttonStartEndMatch.frame =  CGRectMake(106, 284, 107, 37);
        else*/
            buttonStartEndMatch.frame =  CGRectMake(106, 314, 107, 37);
        
        buttonStopResumeTimer.frame  =  CGRectMake(123, 188, 72, 30);
        

        namePlayer1.frame  = CGRectMake(7, 5, 97, 31);
        scorePlayer1.frame = CGRectMake(7, 37, 97, 57);
		poisonPlayer1.frame = CGRectMake(112, 37, 42, 31);
		player1PoisonPlus1.frame = CGRectMake(112, 75, 42, 35);
		player1PoisonMinus1.frame = CGRectMake(112, 118, 42, 35);
		player1Plus1.frame  = CGRectMake(19, 102, 72, 50);
		player1Minus1.frame = CGRectMake(19, 160, 72, 50);
		player1Plus5.frame  = CGRectMake(19, 218, 72, 50);
		player1Minus5.frame = CGRectMake(19, 276, 72, 50);
		
        namePlayer2.frame  = CGRectMake(215, 5, 97, 31);
        scorePlayer2.frame = CGRectMake(215, 37, 97, 57);
		poisonPlayer2.frame = CGRectMake(165, 37, 42, 31);
		player2PoisonPlus1.frame = CGRectMake(165, 75, 42, 35);
		player2PoisonMinus1.frame = CGRectMake(165, 118, 42, 35);
		player2Plus1.frame  = CGRectMake(227, 102, 72, 50);
		player2Minus1.frame = CGRectMake(227, 160, 72, 50);
		player2Plus5.frame  = CGRectMake(227, 218, 72, 50);
		player2Minus5.frame = CGRectMake(227, 276, 72, 50);
        
        // banner fix
        /*if ( self.view.frame.size.height != 411 )
            self.view.frame = CGRectMake(0, 0, 320, 411);*/
        
        if ( self.adMobViewController != nil )
            [self.adMobViewController.view setHidden:NO];
        
    }
    
    //NSLog(@"w : %f, h : %f", self.view.frame.size.width, self.view.frame.size.height);
	
    if ( animation )
        [UIView commitAnimations];
    
    oldInterfaceOrientation = self.interfaceOrientation;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ( [DataAccess rotationCheck:self.interfaceOrientation withOldInterfaceRotation:oldInterfaceOrientation] )
        [self viewRotation:NO];
        
    [super viewWillAppear:animated];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	
	[self viewRotation:YES];
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    self.poison = nil;
    
    self.namePlayer1 = nil;
    self.scorePlayer1 = nil;
    self.poisonPlayer1 = nil;
    self.player1Plus1 = nil;
    self.player1Minus1 = nil;
    self.player1Plus5 = nil;
    self.player1Minus5 = nil;
    self.player1PoisonPlus1 = nil;
    self.player1PoisonMinus1 = nil;
    
    self.namePlayer2 = nil;
    self.scorePlayer2 = nil;
    self.poisonPlayer2 = nil;
    self.player2Plus1 = nil;
    self.player2Minus1 = nil;
    self.player2Plus5 = nil;
    self.player2Minus5 = nil;
    self.player2PoisonPlus1 = nil;
    self.player2PoisonMinus1 = nil;
    
    self.labelNamedTimer = nil;
    self.labelTimer = nil;
    self.buttonStopResumeTimer = nil;
    self.buttonDiceRoll = nil;
    self.buttonGameWin = nil;
    self.buttonStartEndMatch = nil;
    self.dateStartMatch = nil;
    self.dateStartGame = nil;
    
    self.timerUpdateLife = nil;
    self.storyPlayer1 = nil;
    self.storyPlayer2 = nil;
    
    self.viewMana = nil;
    
    self.adView = nil;
    self.tmpButtonForAd = nil;


    [super viewDidUnload];
}


- (void)dealloc {
    
    [poison release];
    
    [namePlayer1 release];
    [scorePlayer1 release];
    [poisonPlayer1 release];
    [player1Plus1 release];
    [player1Minus1 release];
    [player1Plus5 release];
    [player1Minus5 release];
    [player1PoisonPlus1 release];
    [player1PoisonMinus1 release];
    
    [namePlayer2 release];
    [scorePlayer2 release];
    [poisonPlayer2 release];
    [player2Plus1 release];
    [player2Minus1 release];
    [player2Plus5 release];
    [player2Minus5 release];
    [player2PoisonPlus1 release];
    [player2PoisonMinus1 release];
    
    [labelNamedTimer release];
    [labelTimer release];
    [buttonStopResumeTimer release];
    [buttonDiceRoll release];
    [buttonGameWin release];
    [buttonStartEndMatch release];
    [dateStartMatch release];
    [dateStartGame release];
    
	[labelTimer release];
	[timerClock release];
    
    [timerUpdateLife release];
    [storyPlayer1 release];
    [storyPlayer2 release];
    
    [viewMana release];
    
    [adView release];
    [tmpButtonForAd release];

    [super dealloc];
}


@end
