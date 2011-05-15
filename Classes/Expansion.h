//
//  Expansion.h
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Expansion : NSObject {
    NSString *name;
    NSMutableArray *arrayUrlLanguage;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *arrayUrlLanguage;

@end
