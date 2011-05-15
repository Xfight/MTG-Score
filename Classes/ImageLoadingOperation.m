//
//  ImageLoadingOperation.m
//  MyTableView
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageLoadingOperation.h"
#import "ViewSearch.h"

NSString *const ImageResultKey = @"image";
NSString *const URLResultKey = @"url";

@implementation ImageLoadingOperation

- (id)initWithImageURL:(NSURL *)theImageURL target:(id)theTarget action:(SEL)theAction
{
    self = [super init];
    if (self) {
        imageURL = [theImageURL retain];
        target = [theTarget retain];
        action = theAction;
    }
    return self;
}

- (void)dealloc
{
    [imageURL release];
	[target release];
    
    [super dealloc];
}

- (void)main
{
    // Synchronously oad the data from the specified URL.
    NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    // Package it up to send back to our target.
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:image, ImageResultKey, imageURL, URLResultKey, nil];
	
	//NSLog(@"retain count : %d", [target retainCount]);
	
	
	[target performSelectorOnMainThread:action withObject:result waitUntilDone:NO];
    
    [data release];
    [image release];
}

@end