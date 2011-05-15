//
//  XMLParser.m
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser()
@property (nonatomic, retain) NSMutableArray *cards;
@end

@implementation XMLParser
@synthesize url, delegate;
@synthesize cards;

- (id)initWithString:(NSString *)aString
{
    if ( (self = [super init]) )
    {
        //self.url = aUrl;
        NSString *s = [NSString stringWithFormat:@"http://venetomagic.altervista.org/magic/magic_result2_produzione.php?card_name=%@", [aString stringByReplacingOccurrencesOfString:@" " withString:@"+"] ];
        self.url = [NSURL URLWithString:s];
    }
    
    return self;
}

- (id)initWithString:(NSString *)aString andPage:(NSString *)page
{
    
    if ( (self = [super init]) )
    {
        NSString *s = [NSString stringWithFormat:
                       @"http://venetomagic.altervista.org/magic/magic_result2_produzione.php?card_name=%@&card_next=%@",
                       [aString stringByReplacingOccurrencesOfString:@" " withString:@"+"],
                       page
                       ];
        self.url = [NSURL URLWithString:s];
    }
    
    return self;
}

- (id)initWithUrl:(NSURL *)aUrl
{
    if ( (self = [super init]) )
    {
        self.url = aUrl;
    }
    
    return self;
}

- (NSString *)findInString:(NSString *)content withStart:(NSString *)start andEnd:(NSString *)end startFrom:(NSUInteger) pos
{
    NSUInteger length = [content length];
    NSString *s = nil;
    NSRange r, r1;
    r.location = pos;
    r.length = length - pos;
    r = [content rangeOfString:start options:0 range:r];
    if ( r.location == NSNotFound )
        return s;
    
    r1.location = r.location + r.length;
    r1.length = length - r1.location;
    r1 = [content rangeOfString:end options:0 range:r1];
    if ( r1.location == NSNotFound )
        return s;
    
    r.location = r.location + r.length;
    r.length = r1.location - r.location;
    
    s = [content substringWithRange:r];
    return s;
}

- (void)fileRetriever:(FileRetriever *)fileRetriever didFinishRetrieve:(NSString *)content
{
    NSRange r;
    Card *card;
    int length = [content length];
    NSUInteger pos, endPos, tmpPos, tmpEndPos;
    NSString *tmpContent;
    
    if ( ! cards )
        cards = [[NSMutableArray alloc] init];
    
    r.location = 0;
    r.length = length;
    pos = [content rangeOfString:kCardStart options:0 range:r].location;
    
    while ( pos != NSNotFound )
    {
        r.location = pos;
        r.length = length - r.location;
        endPos = [content rangeOfString:kCardEnd options:0 range:r].location;
        
        // ho trovato una carta, devo tirar fuori tutti gli elementi
        card = [[Card alloc] init];
        card.name = [self findInString:content withStart:kNameStart andEnd:kNameEnd startFrom:pos];
        card.ccc = [self findInString:content withStart:kCCCStart andEnd:kCCCEnd startFrom:pos];
        card.cc = [self findInString:content withStart:kCCStart andEnd:kCCEnd startFrom:pos];
        card.image = [self findInString:content withStart:kImageStart andEnd:kImageEnd startFrom:pos];
        card.type = [self findInString:content withStart:kTypeStart andEnd:kTypeEnd startFrom:pos];
        card.text = [self findInString:content withStart:kTextStart andEnd:kTextEnd startFrom:pos];
        
        // ricerca delle faqs
        r.location = pos;
        r.length = endPos - pos;
        tmpPos = [content rangeOfString:kFaqStart options:0 range:r].location;
        card.faqs = [NSMutableArray array];
        
        if ( tmpPos != NSNotFound )
        {
            r.location = tmpPos;
            r.length = length - r.location;
            tmpEndPos = [content rangeOfString:kFaqsEnd options:0 range:r].location;
            
            r.length = tmpEndPos - tmpPos;
            tmpContent = [content substringWithRange:r];
            
            tmpPos = 0;
        }
        
        while ( tmpPos != NSNotFound )
        {
            [card.faqs addObject:[self findInString:tmpContent withStart:kFaqStart andEnd:kFaqEnd startFrom:tmpPos]];
            r.location = tmpPos + [kFaqStart length];
            r.length = [tmpContent length] - r.location;
            
            tmpPos = [tmpContent rangeOfString:kFaqStart options:0 range:r].location;
        }
        
        
        // ricerca espansioni legali
        r.location = pos;
        r.length = endPos - pos;
        tmpPos = [content rangeOfString:kLegalStart options:0 range:r].location;
        card.legals = [NSMutableArray array];
        
        if ( tmpPos != NSNotFound )
        {
            r.location = tmpPos;
            r.length = length - r.location;
            tmpEndPos = [content rangeOfString:kLegalsEnd options:0 range:r].location;
            
            r.length = tmpEndPos - tmpPos;
            tmpContent = [content substringWithRange:r];
            
            tmpPos = 0;
        }
        
        while ( tmpPos != NSNotFound )
        {
            [card.legals addObject:[self findInString:tmpContent withStart:kLegalStart andEnd:kLegalEnd startFrom:tmpPos]];
            r.location = tmpPos + [kLegalStart length];
            r.length = [tmpContent length] - r.location;
            
            tmpPos = [tmpContent rangeOfString:kLegalStart options:0 range:r].location;
        }
        
        // ricerca di succ
        if ( card.name == nil )
            card.succ = [self findInString:content withStart:kSuccStart andEnd:kSuccEnd startFrom:pos];
        
        
        [cards addObject:card];
        [card release];
        
        r.location = endPos;
        r.length = length - r.location;
        pos = [content rangeOfString:kCardStart options:0 range:r].location;
    }
    
    [self.delegate xmlParser:self didFinishWithResult:cards];
}

- (void)fileRetriever:(FileRetriever *)fileRetriever didFailWithError:(NSError *)error
{
    [self.delegate xmlParser:self didFailWithError:error];
}

- (void)startParsing
{
    FileRetriever *f = [[[FileRetriever alloc] initWithURL:self.url] autorelease];
    f.delegate = self;
    [f startRetrieveFile];
}

- (NSString *)description
{
    return @"sono il parser !!!!";
}

- (void)dealloc
{
    [url release];
    [cards release];
    
    [super dealloc];
}

@end
