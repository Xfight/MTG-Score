//
//  EditableTableCell.h
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableTableCell : UITableViewCell {
    IBOutlet UITextField *myTextField;
    IBOutlet UILabel *myLabel;
}

@property (retain) IBOutlet UITextField *myTextField;
@property (retain) IBOutlet UILabel *myLabel;

@end
