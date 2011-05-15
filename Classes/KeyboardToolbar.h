//
//  KeyboardToolbar.h
//  WebViewSearching
//
//  Created by Luca on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUIToolBar.h"

@class KeyboardToolbar;

@protocol KeyboardToolbarDelegate
- (void)keyboardToolbar:(KeyboardToolbar *)keyboardToolbar didStartSearch:(NSString *)text;
@end

@interface KeyboardToolbar : NSObject <MyUIToolBarDelegate> {
    UITextField *tmpTextField;
    
    UIButton *buttonCover;
    UIView *superView;
    
    MyUIToolBar *myUIToolBar;
    
    id<KeyboardToolbarDelegate> delegate;
}

@property (nonatomic, retain) UIView *superView;
@property (assign) id<KeyboardToolbarDelegate> delegate;

- (id)initWithSuperView:(UIView *)aView;
- (void)displayKeyboard;

@end
