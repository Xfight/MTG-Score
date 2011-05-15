//
//  ObjectPair.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectPair : NSObject {
    NSString *string1;
    NSString *string2;
}

@property (nonatomic, copy) NSString *string1;
@property (nonatomic, copy) NSString *string2;

- (id)initWithString1:(NSString *)s1 andString2:(NSString *)s2;
+ (ObjectPair *)objectPairString1:(NSString *)s1 andString2:(NSString *)s2;

@end
