//
//  ViewGameCurrent.h
//  MTG Score
//
//  Created by Luca Bertani on 25/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"

#define MAX_SIZE_NAME_PORTRAIT  134.0
#define MAX_SIZE_NAME_LANDSCAPE 200.0
#define SIZE_3_DOT      14.0

#define TABLE_CSS_PORTRAIT  @"style-portrait.css"
#define TABLE_CSS_LANDSCAPE @"style-landscape.css"

@interface ViewGameCurrent : UIViewController {
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

@end
