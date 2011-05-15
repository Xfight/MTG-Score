//
//  FileRetriever.m
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileRetriever.h"


@implementation FileRetriever
@synthesize url;
@synthesize delegate;

- (id)init
{
	if ( (self = [super init]) ) {
		// initalization
	}
	
	return self;
}

- (id)initWithURL:(NSURL *)aUrl
{
	if ( (self = [super init]) ) {
		// initalization
        self.url = aUrl;
	}
	
	return self;
}

- (void)threadComplete:(NSString *)s
{
    [self.delegate fileRetriever:self didFinishRetrieve:s];
}

- (void)threadFail:(NSError *)error
{
    [self.delegate fileRetriever:self didFailWithError:error];
}

- (void)threadRetrieve
{
    NSAutoreleasePool* myAutoreleasePool = [[NSAutoreleasePool alloc] init];
    
    NSError *error = nil;
    
    if ( [MyConnection isConnected] ) {
        NSString *s = [NSString stringWithContentsOfURL:self.url
                                encoding:NSUTF8StringEncoding
                                error:&error];
        
        if ( ! error )
            [self performSelectorOnMainThread:@selector(threadComplete:) withObject:s waitUntilDone:NO];
        else
            [self performSelectorOnMainThread:@selector(threadFail:) withObject:error waitUntilDone:NO];
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"No connection avaible" forKey:NSLocalizedDescriptionKey];
        error = [[NSError alloc] initWithDomain:@"Connection" code:404 userInfo:errorDetail];
        [self performSelectorOnMainThread:@selector(threadFail:) withObject:error waitUntilDone:YES];
    }
    
    [myAutoreleasePool release];
}

- (void)startRetrieveFile
{
    [NSThread detachNewThreadSelector:@selector(threadRetrieve) toTarget:self withObject:nil];
}

- (void)dealloc
{
    [url release];
    [super dealloc];
}

@end
