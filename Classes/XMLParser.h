//
//  XMLParser.h
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "FileRetriever.h"

#define kCardStart  @"<card>"
#define kCardEnd    @"</card>"
#define kNameStart  @"<name>"
#define kNameEnd    @"</name>"
#define kCCCStart   @"<ccc>"
#define kCCCEnd     @"</ccc>"
#define kCCStart    @"<cc>"
#define kCCEnd      @"</cc>"
#define kImageStart @"<image>"
#define kImageEnd   @"</image>"
#define kTypeStart  @"<type>"
#define kTypeEnd    @"</type>"
#define kTextStart  @"<text>"
#define kTextEnd    @"</text>"
#define kFaqsStart  @"<faqs>"
#define kFaqsEnd    @"</faqs>"
#define kFaqStart   @"<faq>"
#define kFaqEnd     @"</faq>"
#define kLegalsStart @"<legals>"
#define kLegalsEnd  @"</legals>"
#define kLegalStart @"<legal>"
#define kLegalEnd   @"</legal>"

#define kSuccStart  @"<succ>"
#define kSuccEnd    @"</succ>"

@class XMLParser;

@protocol XMLParserDelegate <NSObject>
- (void)xmlParser:(XMLParser *)xmlParser didFinishWithResult:(NSMutableArray *)cards;
- (void)xmlParser:(XMLParser *)xmlParser didFailWithError:(NSError *)error;
@end

@interface XMLParser : NSObject <FileRetrieverDelegate> {
    NSURL *url;
    NSMutableArray *cards;
    
    id<XMLParserDelegate> delegate;
}

@property (nonatomic, retain) NSURL *url;
@property (assign) id<XMLParserDelegate> delegate;

- (id)initWithString:(NSString *)aString;
- (id)initWithString:(NSString *)aString andPage:(NSString *)page;
- (id)initWithUrl:(NSURL *)aUrl;
- (void)startParsing;

@end
