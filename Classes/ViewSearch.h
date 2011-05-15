//
//  ViewSearch.h
//  MTG SK
//
//  Created by Luca on 21/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Card.h"
#import "ViewCard.h"
#import "ViewLoading.h"
#import "MyConnection.h"


@interface ViewSearch : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate> {
	// array of Card
	NSMutableArray *tableData;
	NSMutableArray *results;
	XMLParser *xml;
	
	UITableView *theTableView;
    UISearchBar *theSearchBar;
	UIView *disableViewOverlay;
	
	Card *prevCard;
	ViewLoading *viewLoading;
}

@property (retain) NSMutableArray *tableData;
@property (retain) NSMutableArray *results;
@property (retain) UIView *disableViewOverlay;
@property (nonatomic, retain) XMLParser *xml;
@property (nonatomic, retain) Card *prevCard;

@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;
@property (nonatomic, retain) IBOutlet ViewLoading *viewLoading;

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;

@end
