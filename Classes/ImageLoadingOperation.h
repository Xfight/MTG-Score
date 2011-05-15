//
//  ImageLoadingOperation.h
//  MyTableView
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ImageResultKey;
extern NSString *const URLResultKey;

@interface ImageLoadingOperation : NSOperation {
    NSURL *imageURL;
    id target;
    SEL action;
}

- (id)initWithImageURL:(NSURL *)imageURL target:(id)target action:(SEL)action;

@end
