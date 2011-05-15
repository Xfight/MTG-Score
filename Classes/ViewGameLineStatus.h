//
//  ViewGameLineStatus.h
//  MTG Score
//
//  Created by Luca Bertani on 24/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"
#import "GameSingle.h"
#import "GameHistory.h"

#define MAX_SIZE_NAME_PORTRAIT  134.0
#define MAX_SIZE_NAME_LANDSCAPE 200.0
#define SIZE_3_DOT      14.0

#define TABLE_CSS_PORTRAIT  @"style-portrait.css"
#define TABLE_CSS_LANDSCAPE @"style-landscape.css"

@interface ViewGameLineStatus : UIViewController {
    GameHistory *gameHistory;
    GameSingle *gameSingle;
    
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) GameHistory *gameHistory;
@property (nonatomic, retain) GameSingle *gameSingle;
@property (nonatomic, retain) UIWebView *webView;

@end
