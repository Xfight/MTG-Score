//
//  WebViewSearch.h
//  WebViewSearching
//
//  Created by Luca on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardToolbar.h"

@interface WebViewSearch : NSObject <KeyboardToolbarDelegate> {
    UIWebView *webView;
    UIViewController *superView;
    
    KeyboardToolbar *myKeyboardToolbar;
    UIBarButtonItem *buttonNext;
    UILabel *labelDescription;
    int minimunWordLength;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIViewController *superView;
@property (nonatomic, retain) KeyboardToolbar *myKeyboardToolbar;
@property (nonatomic, retain) UIBarButtonItem *buttonNext;
@property (nonatomic, retain) UILabel *labelDescription;
@property (nonatomic) int minimunWordLength;

- (id)initWithWebView:(UIWebView *)aWebView andSuperView:(UIViewController *)aSuperView;
- (void)integrateWithSystem;
- (void)removeCustomization;

@end
