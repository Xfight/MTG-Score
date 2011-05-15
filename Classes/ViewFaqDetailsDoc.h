//
//  ViewFaqDetailsDoc.h
//  MTG Score
//
//  Created by Luca on 15/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PairUrlLanguage.h"
#import "ViewLoading.h"
#import "WebViewSearch.h"

@interface ViewFaqDetailsDoc : UIViewController<UIWebViewDelegate, UIActionSheetDelegate> {
    PairUrlLanguage *pul;
    IBOutlet UIWebView *web;
    ViewLoading *viewLoading;
    
    WebViewSearch *webViewSearch;
    
    BOOL redirect;
}

@property (nonatomic, retain) PairUrlLanguage *pul;
@property (nonatomic, retain) UIWebView *web;
@property (nonatomic, retain) ViewLoading *viewLoading;
@property (nonatomic, retain) WebViewSearch *webViewSearch;

- (IBAction)menuOpenInSafari:(UIBarButtonItem *)sender;

@end
