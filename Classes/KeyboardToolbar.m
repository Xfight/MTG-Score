//
//  KeyboardToolbar.m
//  WebViewSearching
//
//  Created by Luca on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeyboardToolbar.h"

@interface KeyboardToolbar()
@property (nonatomic, retain) UIButton *buttonCover;
@property (nonatomic, retain) UITextField *tmpTextField;
@property (nonatomic, retain) MyUIToolBar *myUIToolBar;
@end


@implementation KeyboardToolbar
@synthesize buttonCover, superView, myUIToolBar, tmpTextField, delegate;

- (UIButton *)buttonCover
{
    if ( buttonCover == nil )
    {
        buttonCover = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        buttonCover.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [buttonCover addTarget:self action:@selector(removeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return buttonCover;
}

- (UITextField *)tmpTextField
{
    if ( tmpTextField == nil )
    {
        tmpTextField = [[UITextField alloc] init];
        tmpTextField.backgroundColor = [UIColor redColor];
        tmpTextField.hidden = YES;
    }
    
    return tmpTextField;
}

- (MyUIToolBar *)myUIToolBar
{
    if ( myUIToolBar == nil )
    {
        myUIToolBar = [[MyUIToolBar alloc] init];
        myUIToolBar.delegate = self;
    }
    
    return myUIToolBar;
}

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    
    return self;
}

- (id)initWithSuperView:(UIView *)aView
{
    if ((self = [super init]))
    {
        self.superView = aView;
    }
    
    return self;
}

- (void)removeKeyboard
{
    //[self.textField resignFirstResponder];
    
    //[self.textField removeFromSuperview];
    [self.buttonCover removeFromSuperview];
    self.tmpTextField.inputAccessoryView = nil;
    [self.tmpTextField removeFromSuperview];
    [self.myUIToolBar.view removeFromSuperview];
}

- (void)displayKeyboard
{
    self.buttonCover.frame = CGRectMake(0, 0, self.superView.bounds.size.width , self.superView.bounds.size.height);
        
    /*if ( self.textField.inputAccessoryView == nil )
        self.textField.inputAccessoryView = self.keyboardToolbar;*/
    if ( self.tmpTextField.inputAccessoryView == nil )
        self.tmpTextField.inputAccessoryView = self.myUIToolBar.view;
    
    [self.superView addSubview:self.buttonCover];
    [self.superView addSubview:self.tmpTextField];
    [self.tmpTextField becomeFirstResponder];
    
    // really bad trick but it works ^^
    [self.myUIToolBar.textField becomeFirstResponder];
    //self.tmpTextField.hidden = YES;    
    
    /*[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect frame = self.keyboardToolbar.frame;
    frame.origin.y = self.superView.bounds.size.height - 207.0;
    self.keyboardToolbar.frame = frame;
    
    [UIView commitAnimations];*/
}

//- (void)myUIToolBarDidPressSearchButton:(MyUIToolBar *)myUIToolBar
- (void)myUIToolBar:(MyUIToolBar *)myUIToolBar didPressSearchButton:(NSString *)text
{
    [self removeKeyboard];
    [self.delegate keyboardToolbar:self didStartSearch:text];
}

- (void)dealloc
{
    [buttonCover release];
    [superView release];
    [tmpTextField release];
    [myUIToolBar release];
    
    [super dealloc];
}

@end
