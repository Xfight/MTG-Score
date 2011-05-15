//
//  ViewCard.h
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

#define imagePadPortrait    25
#define imagePadLandscape   105

@interface ViewCard : UIViewController <UIWebViewDelegate> {
	Card *card;
    
    IBOutlet UIWebView *myWebView;
    IBOutlet UINavigationItem *navTitle;
}

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) UINavigationItem *navTitle;

@end
