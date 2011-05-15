//
//  MyUIToolBar.h
//  WebViewSearching
//
//  Created by Luca on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyUIToolBar;

@protocol MyUIToolBarDelegate
- (void)myUIToolBar:(MyUIToolBar *)myUIToolBar didPressSearchButton:(NSString *)text;
@end

@interface MyUIToolBar : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *textField;
    IBOutlet UIBarButtonItem *buttonSearch;
    
    id<MyUIToolBarDelegate> delegate;
}

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIBarButtonItem *buttonSearch;

@property (assign) id<MyUIToolBarDelegate> delegate;

- (IBAction)pressButtonSearch:(UIBarButtonItem *)sender;

@end
