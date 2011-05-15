//
//  FaqAnalyzer.h
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expansion.h"
#import "PairUrlLanguage.h"

#define kRtf    @".rtf"
#define kDoc    @".doc"
#define kAsp    @".asp"
#define kTxt    @".txt"

#define kCutStart           @"<table>"
#define kCutEnd             @"<div class=\"article-bottom\"></div>"

#define kExpansionStartName  @"<i>"
#define kExpansionEndName    @"</i>"

#define kLinkBase       @"http://www.wizards.com"
#define kLinkStart      @"<a href=\""
#define kLinkEnd        @"\">"
#define kLinkNameEnd    @"</a>"
#define kLinkPad        100

@interface FaqAnalyzer : NSObject {
    NSString *content;
    NSUInteger length;
    NSString *contentCut;
}

@property (nonatomic, copy) NSString *content;

- (id)initWithContent:(NSString *)aContent;
- (NSMutableArray *)analyzeContent;

@end
