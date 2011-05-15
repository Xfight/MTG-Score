//
//  Card.h
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject {
	NSString *name;
	NSString *ccc;
	NSString *cc;
	NSString *image;
	NSString *type;
	NSString *text;
	NSMutableArray *faqs;
	NSMutableArray *legals;
	
	NSString *prev;
	NSString *succ;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *ccc;
@property (nonatomic, retain) NSString *cc;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSMutableArray *faqs;
@property (nonatomic, retain) NSMutableArray *legals;
@property (nonatomic, retain) NSString *prev;
@property (nonatomic, retain) NSString *succ;

@end
