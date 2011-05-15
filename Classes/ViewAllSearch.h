//
//  ViewAllSearch.h
//  MTG Score
//
//  Created by Luca on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFaq.h"
#import "ViewSearch.h"

@interface ViewAllSearch : UITableViewController {
    NSArray *tableData;
    
    ViewFaq *viewFaq;
    ViewSearch *viewSearch;
}

@end
