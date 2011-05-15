//
//  PairUrlLanguage.m
//  MTG Score
//
//  Created by Luca on 15/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PairUrlLanguage.h"


@implementation PairUrlLanguage
@synthesize language, urlLink;

- (id)init
{
	if ( (self = [super init]) ) {
		// initalization
        self.language = nil;
        self.urlLink = nil;
	}
	
	return self;
}

- (id)initWithLanguage:(NSString *)aLanguage andUrl:(NSURL *)aUrl
{
    if ( (self = [super init]) ) {
		// initalization
        self.language = aLanguage;
        self.urlLink = aUrl;
	}
	
	return self;
}

- (void)dealloc
{
    [language release];
    [urlLink release];
    [super dealloc];
}

@end
