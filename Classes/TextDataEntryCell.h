//
//  TextDataEntryCell.h
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataEntryCell.h"

@interface TextDataEntryCell : BaseDataEntryCell <UITextFieldDelegate> {
	
}

@property (nonatomic, retain) UITextField *textField;

@end
