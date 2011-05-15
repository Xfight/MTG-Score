//
//  FaqAnalyzer.m
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FaqAnalyzer.h"

@implementation FaqAnalyzer
@synthesize content;

- (id)init
{
	if ( (self = [super init]) ) {
		// initalization
        self.content = nil;
	}
	
	return self;
}

- (id)initWithContent:(NSString *)aContent
{
	if ( (self = [super init]) ) {
		// initalization
        self.content = aContent;
	}
	
	return self;
}

- (NSString *)textCut
{
    NSString *result = nil;
    NSRange r;
    r.length = length;
    r.location = 0;
    
    NSRange rStart = [self.content rangeOfString:kCutStart options:0 range:r];
    if ( rStart.location > 0 ) {
        NSRange rEnd = [self.content rangeOfString:kCutEnd options:0 range:r];
        r.location = rStart.location;
        r.length = rEnd.location - r.location;
        result = [self.content substringWithRange:r];
    }
    
    return result;
}

- (NSUInteger)tryToFindTheFirst:(NSUInteger)position
{
    //NSStringCompareOptions
    NSRange r;
    r.location = position;
    r.length = length - position;
    NSUInteger min;
    
    NSUInteger posRtf = [contentCut rangeOfString:kRtf options:NSCaseInsensitiveSearch range:r].location;
    //if ( min > posRtf )
    min = posRtf;
    
    NSUInteger posTxt = [contentCut rangeOfString:kTxt options:NSCaseInsensitiveSearch range:r].location;
    if ( min > posTxt )
        min = posTxt;
    
    NSUInteger posAsp = [contentCut rangeOfString:kAsp options:NSCaseInsensitiveSearch range:r].location;
    if ( min > posAsp )
        min = posAsp;
    
    NSUInteger posDoc = [contentCut rangeOfString:kDoc options:NSCaseInsensitiveSearch range:r].location;
    if ( min > posDoc )
        min = posDoc;
    
    return min;
    
    /*if ( min == posRtf )        return kRtf;
    else if ( min == posTxt )   return  kTxt;
    else if ( min == posAsp )   return kAsp;
    else if ( min == posDoc )   return kDoc;
    else                        return nil; // ?!?*/
}

- (NSString *)retrieveExpansionName:(NSUInteger)position
{
    NSString *result = nil;
    NSRange r;
    r.location = 0;
    r.length = position;
    NSString *tmpStr = [contentCut substringWithRange:r];
    
    
    NSRange rStart = [tmpStr rangeOfString:kExpansionStartName options:NSBackwardsSearch range:r];
    
    if (rStart.location > 0) {
        r.location = rStart.location;
        r.length = [tmpStr length] - r.location;
        NSRange rEnd = [tmpStr rangeOfString:kExpansionEndName options:0 range:r];
        r.location = rStart.location + [kExpansionStartName length];
        r.length = rEnd.location - r.location;
        result = [tmpStr substringWithRange:r];
    }
    
    result = [result stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return result;
}

- (PairUrlLanguage *)retrieveLink:(NSUInteger)position
{
    PairUrlLanguage *pul = [[[PairUrlLanguage alloc] init] autorelease];
    
    NSString *result = nil;
    NSRange r;
    r.location = 0;
    r.length = position;
    NSString *tmpStr = [contentCut substringWithRange:r];
    
    NSRange rStart = [tmpStr rangeOfString:kLinkStart options:NSBackwardsSearch range:r];
    
    if (rStart.location > 0) {
        r.location = rStart.location;
        r.length = 100;
        NSRange rEnd = [contentCut rangeOfString:kLinkEnd options:0 range:r];
        r.location = rStart.location + [kLinkStart length];
        r.length = rEnd.location - r.location;
        result = [contentCut substringWithRange:r];
    }
    
    result = [NSString stringWithFormat:@"%@%@", kLinkBase, result];
    pul.urlLink = [NSURL URLWithString:[result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    
    r.location = r.location + r.length + [kLinkEnd length];
    r.length = length - r.location;
    
    rStart = [contentCut rangeOfString:kLinkNameEnd options:0 range:r];
    r.length = rStart.location - r.location;
    result = [contentCut substringWithRange:r];
    pul.language = result;
    
    return pul;
}

- (NSMutableArray *)analyzeContent
{
    
    NSMutableArray *expansions = [NSMutableArray array];
    
    if ( content == nil )
        return expansions;
    
    // 4 estensioni da controllare !
    // file : rtf, doc, asp, txt
    length = [content length];
    //BOOL find = YES;
    
    contentCut = [self textCut];
    length = [contentCut length];

    NSUInteger pos = [self tryToFindTheFirst:0];
    //NSString *ext = [self tryToFindTheFirst:pos];
    NSString *title = nil;
    NSString *oldTitle = [self retrieveExpansionName:pos];
    
    int count = 0;
    Expansion *exp = [[Expansion alloc] init];
    exp.name = oldTitle;
    [expansions addObject:exp];
    [exp release];
    
    PairUrlLanguage *pul = nil;
    
    while (pos < length) {
        
        title = [self retrieveExpansionName:pos];
        
        if ( [title isEqualToString:oldTitle] ) {
            // ho già questa espansione nell'array nella posizione count !
            exp = (Expansion*) [expansions objectAtIndex:count];
            
            // recupero il link da inserire nelle faq !
            pul = [self retrieveLink:pos];
            [exp.arrayUrlLanguage addObject:pul];
        } else {
            // nuova espansione !
            count += 1;
            
            exp = [[Expansion alloc] init];
            exp.name = title;
            
            // recupero il link da inserire nelle faq !
            pul = [self retrieveLink:pos];
            
            // workaround per un link che ha diversi redirect...
            if ( [title isEqualToString:@"Ice Age"] || [title isEqualToString:@"Alliances"] )
                pul.urlLink = [NSURL URLWithString:@"http://www.wizards.com/Magic/TCG/Article.aspx?x=magic/faq/iceage"];
            
            [exp.arrayUrlLanguage addObject:pul];
            
            [expansions addObject:exp];
            [exp release];
        }
        
        //[oldTitle release];
        oldTitle = title;
        
        //if ( [oldTitle isEqualToString:@"Ice Age"] )
        //    NSLog(@"ICE AGE!!!");
        pos = [self tryToFindTheFirst:pos+2];
        
        //NSLog(@"title : %@", title);
    }
    
    return expansions;
}

- (void)dealloc
{
    [content release];
    [super dealloc];
}

@end
