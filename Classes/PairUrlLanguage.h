//
//  PairUrlLanguage.h
//  MTG Score
//
//  Created by Luca on 15/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PairUrlLanguage : NSObject {
    NSString *language;
    NSURL *urlLink;
}

@property (nonatomic, copy) NSString *language;
@property (nonatomic, retain) NSURL *urlLink;

- (id)initWithLanguage:(NSString *)aLanguage andUrl:(NSURL *)aUrl;

@end
