//
//  ViewFaqDetails.h
//  MTG Score
//
//  Created by Luca on 15/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expansion.h"
#import "PairUrlLanguage.h"
#import "ViewFaqDetailsDoc.h"

@interface ViewFaqDetails : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Expansion *expansion;
}

@property (nonatomic, retain) Expansion *expansion;

@end
