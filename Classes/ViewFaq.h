//
//  ViewFaq.h
//  MTG Score
//
//  Created by Luca on 14/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileRetriever.h"
#import "ViewLoading.h"
#import "FaqAnalyzer.h"
#import "ViewFaqDetails.h"

@interface ViewFaq : UITableViewController <FileRetrieverDelegate, UITableViewDelegate, UITableViewDataSource> {
    ViewLoading *viewLoading;
    
    NSArray *expansions;
}

@property (nonatomic, retain) ViewLoading *viewLoading;
@property (retain) NSArray *expansions;

@end
