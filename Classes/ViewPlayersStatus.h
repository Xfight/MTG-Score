//
//  ViewPlayersStatus.h
//  MTG Score
//
//  Created by Luca on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerStatus.h"
#import "DataAccess.h"

@interface ViewPlayersStatus : UIViewController {
    NSMutableArray *arrayPlayer1;
    NSString *player1Name;
    NSMutableArray *arrayPlayer2;
    NSString *player2Name;
    
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) NSMutableArray *arrayPlayer1;
@property (nonatomic, copy) NSString *player1Name;
@property (nonatomic, retain) NSMutableArray *arrayPlayer2;
@property (nonatomic, copy) NSString *player2Name;
@property (nonatomic, retain) UIWebView *webView;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;
- (IBAction)doneButton:(UIBarButtonItem *)sender;

@end
