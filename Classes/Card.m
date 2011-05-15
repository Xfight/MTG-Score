//
//  Card.m
//  MTG SK
//
//  Created by Luca on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize name, ccc, cc, image, type, text, faqs, legals, prev, succ;

/*
 NSString *name;
 NSString *ccc;
 NSString *cc;
 NSString *image;
 NSString *type;
 NSString *text;
 NSMutableArray *faqs;
 NSMutableArray *legals;
 */

- (void) dealloc {
	[name release];
	[ccc release];
	[cc release];
	[image release];
	[type release];
	[text release];
	[faqs release];
	[legals release];
	[prev release];
	[succ release];
	
	name = nil;
	ccc = nil;
	cc = nil;
	image = nil;
	type = nil;
	text = nil;
	faqs = nil;
	legals = nil;
	prev = nil;
	succ = nil;
	
	[super dealloc];
}

@end
