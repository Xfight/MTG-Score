//
//  ObjectTableCell.h
//  MTG Score
//
//  Created by Luca on 20/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectTableCell : NSObject {
    NSString *title;
    NSString *text;
    id obj;
    int tag;
    NSString *reuseIdentifier;
    NSString *tableCellType;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) id obj;
@property (nonatomic) int tag;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) NSString *tableCellType;

- (id)initWithTitle:(NSString *)aTitle andText:(NSString *)aText andObj:(id)aObj andTag:(int)aTag andReuseIdentifier:(NSString *)aReuseIdentifier andTableCellType:(NSString *)aTableCellType;
+ (ObjectTableCell *)objectTableCell:(NSString *)aTitle andText:(NSString *)aText andObj:(id)aObj andTag:(int)aTag andReuseIdentifier:(NSString *)aReuseIdentifier andTableCellType:(NSString *)aTableCellType;


@end
