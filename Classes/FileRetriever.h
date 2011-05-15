//
//  FileRetriever.h
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConnection.h"

@class FileRetriever;

@protocol FileRetrieverDelegate <NSObject>
- (void)fileRetriever:(FileRetriever *)fileRetriever didFinishRetrieve:(NSString *)content;
- (void)fileRetriever:(FileRetriever *)fileRetriever didFailWithError:(NSError *)error;
@end

@interface FileRetriever : NSObject {
    NSURL *url;
    id<FileRetrieverDelegate> delegate;
}

@property (assign) id<FileRetrieverDelegate> delegate;
@property (nonatomic, retain) NSURL *url;

- (id)initWithURL:(NSURL *)aUrl;
- (void)startRetrieveFile;

@end
