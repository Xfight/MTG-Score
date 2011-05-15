//
//  ObjectPair.m
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ObjectPair.h"


@implementation ObjectPair
@synthesize string1, string2;

- (id)init
{
    if (( self = [super init] ))
    {
        
    }
    
    return self;
}

- (id)initWithString1:(NSString *)s1 andString2:(NSString *)s2
{
    if (( self = [super init] ))
    {
        self.string1 = s1;
        self.string2 = s2;
    }
    
    return self;
}

+ (ObjectPair *)objectPairString1:(NSString *)s1 andString2:(NSString *)s2
{
    return [[[ObjectPair alloc] initWithString1:s1 andString2:s2] autorelease];
}

- (void)dealloc
{
    [string1 release];
    [string2 release];
    [super dealloc];
}

@end
