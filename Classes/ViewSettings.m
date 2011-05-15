//
//  ViewSettings.m
//  MTG SK
//
//  Created by Luca on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MTG_ScoreKeeperAppDelegate.h"

@implementation ViewSettings
@synthesize vsk;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Mi registro come observer delle notifice di editing completo che arrivano dalle celle custom
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(cellControlDidEndEditing:)
	 name:CELL_ENDEDIT_NOTIFICATION_NAME
	 object:nil];      
	
	
	NSString *plisStructure = [[NSBundle mainBundle] pathForResource:@"table-structure.plist" ofType:nil];
	
    tableStructure = [[NSArray arrayWithContentsOfFile:plisStructure] retain];
	
	if ( tableData == nil ) {
		tableData = [[NSMutableArray alloc] init];
	}
	
	// deve rispettare l'ordine della tableStructure
	
	BOOL b = [DataAccess boolForKey:K_ENABLE_HISTORY];
    [tableData addObject:[NSNumber numberWithInt:b]];
    
    b = [DataAccess boolForKey:K_ENABLE_TIMER];
	[tableData addObject:[NSNumber numberWithInt:b]];
	
	b = [DataAccess boolForKey:K_REVERSE_COUNT_TIME];
	[tableData addObject:[NSNumber numberWithInt:b]];
	
	[tableData addObject:[NSString stringWithFormat:@"%.2d:%.2d:%.2d",
						  [DataAccess intForKey:K_REVERSE_HOUR],
						  [DataAccess intForKey:K_REVERSE_MINUTE],
						  [DataAccess intForKey:K_REVERSE_SECOND]]
		];
	
	b = [DataAccess boolForKey:K_ALARM_ON_TEN_MINUTES];
	[tableData addObject:[NSNumber numberWithInt:b]];
	b = [DataAccess boolForKey:K_ALARM_ON_END_TIME];
	[tableData addObject:[NSNumber numberWithInt:b]];
	b = [DataAccess boolForKey:K_DISPLAY_SLEEP];
	[tableData addObject:[NSNumber numberWithInt:b]];
	
	[tableData addObject:[DataAccess colorForKey:K_BACKGROUND_COLOR]];
	
	[tableData addObject:[DataAccess colorForKey:K_TEXT_TIMER_COLOR]];
}

-(void)cellControlDidEndEditing:(NSNotification *)notification
{
	NSIndexPath *cellIndex = (NSIndexPath *)[notification object];
	BaseDataEntryCell *cell = (BaseDataEntryCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
	if(cell != nil)
	{ 
		//NSLog(@"L'utente ha digitato %@ per la DataKey %@",  [cell getControlValue], cell.dataKey);
		//[cell savePersistence];
        
        if ( [cell.dataKey isEqualToString:K_ENABLE_HISTORY] )
        {
            
            [tableData replaceObjectAtIndex:0 withObject:[cell getControlValue]];			
			[DataAccess setBool:[cell getBooleanValue] forKey:K_ENABLE_HISTORY];
            
        } else if ( [cell.dataKey isEqualToString:K_ENABLE_TIMER] ) {
			
			[tableData replaceObjectAtIndex:1 withObject:[cell getControlValue]];			
			[DataAccess setBool:[cell getBooleanValue] forKey:K_ENABLE_TIMER];
			
		} else if ( [cell.dataKey isEqualToString:K_REVERSE_COUNT_TIME] ) {
			
			[tableData replaceObjectAtIndex:2 withObject:[cell getControlValue]];			
			[DataAccess setBool:[cell getBooleanValue] forKey:K_REVERSE_COUNT_TIME];
			
		} else if ( [cell.dataKey isEqualToString:K_REVERSE_HOUR] ) {
			
			[tableData replaceObjectAtIndex:3 withObject:[cell getControlValue]];
			NSString *string = [cell getControlValue];
			NSRange n;
			n.location = 0;
			n.length = 2;
			
			int h = [[string substringWithRange:n] intValue];
			n.location = 3;
			int m = [[string substringWithRange:n] intValue];
			n.location = 6;
			int s = [[string substringWithRange:n] intValue];
			
			[DataAccess setInt:h forKey:K_REVERSE_HOUR];
			[DataAccess setInt:m forKey:K_REVERSE_MINUTE];
			[DataAccess setInt:s forKey:K_REVERSE_SECOND];
			
		} else if ( [cell.dataKey isEqualToString:K_ALARM_ON_TEN_MINUTES] ) {
			
			[tableData replaceObjectAtIndex:4 withObject:[cell getControlValue]];
			[DataAccess setBool:[cell getBooleanValue] forKey:K_ALARM_ON_TEN_MINUTES];
			
		} else if ( [cell.dataKey isEqualToString:K_ALARM_ON_END_TIME] ) {
			
			[tableData replaceObjectAtIndex:5 withObject:[cell getControlValue]];
			[DataAccess setBool:[cell getBooleanValue] forKey:K_ALARM_ON_END_TIME];
			
		} else if ( [cell.dataKey isEqualToString:K_DISPLAY_SLEEP] ) {
			
			[tableData replaceObjectAtIndex:6 withObject:[cell getControlValue]];
			[DataAccess setBool:[cell getBooleanValue] forKey:K_DISPLAY_SLEEP];
			
		} else if ( [cell.dataKey isEqualToString:K_BACKGROUND_COLOR] ) {
			
			[tableData replaceObjectAtIndex:7 withObject:[cell getControlValue]];
			UIColor *c = (UIColor *) [cell getControlValue];
			
			if ( [c isEqual:[UIColor groupTableViewBackgroundColor]] )
				[DataAccess setBool:YES forKey:K_BACKGROUND_COLOR_TABLE];
			else
				[DataAccess setBool:NO forKey:K_BACKGROUND_COLOR_TABLE];
			
			[DataAccess setColor:c forKey:K_BACKGROUND_COLOR];
			
			MTG_ScoreKeeperAppDelegate *m = (MTG_ScoreKeeperAppDelegate *) [[UIApplication sharedApplication] delegate];
			[m updateBackgroundColor:c];
		} else if ( [cell.dataKey isEqualToString:K_TEXT_TIMER_COLOR] ) {
			
			[tableData replaceObjectAtIndex:8 withObject:[cell getControlValue]];
			UIColor *c = (UIColor *) [cell getControlValue];
			[DataAccess setColor:c forKey:K_TEXT_TIMER_COLOR];
		}
		
		[DataAccess forseSync];
		[vsk readDatabaseFirstTime:NO];
	}		
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	/*MTG_ScoreKeeperAppDelegate *m = (MTG_ScoreKeeperAppDelegate *) [[UIApplication sharedApplication] delegate];
	[m propagateRotation:interfaceOrientation duration:duration noView:3];*/
}
 


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableStructure count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ( indexPath.row != 1 )
		return 44.0f;
	else
		return 50.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //static NSString *CellIdentifier = @"Cell";
	
    NSDictionary *cellData = [tableStructure objectAtIndex:indexPath.row];
	NSString *dataKey = [cellData objectForKey:@"DataKey"];
	NSString *cellType = [cellData objectForKey:@"CellType"];
    
	BaseDataEntryCell *cell = (BaseDataEntryCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
	
	if (cell == nil) {
        cell = [[[NSClassFromString(cellType) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType] autorelease];
        cell.superViewController = self;
    }
	
	// Impostiamo la datakey della cella
	cell.dataKey = dataKey;
	cell.textLabel.text = [cellData objectForKey:@"Label"];
	[cell setControlValue:[tableData objectAtIndex:indexPath.row]];
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	BaseDataEntryCell *cell = (BaseDataEntryCell *) [tableView cellForRowAtIndexPath:indexPath];
	if ( [cell isKindOfClass:[TimeDataEntryCell class] ] ) {
		MTG_ScoreKeeperAppDelegate *m = [[UIApplication sharedApplication] delegate];
		TimeDataEntryCell *cell1 = (TimeDataEntryCell *) cell;
		
		TimeDataChoose *v = [[TimeDataChoose alloc] init];
		v.timeDataEntryCell = cell1;
		
		NSString *string = [cell1.label titleForState:UIControlStateNormal];
		NSRange n;
		n.location = 0;
		n.length = 2;
		
		int hour = [[string substringWithRange:n] intValue];
		n.location = 3;
		int minute = [[string substringWithRange:n] intValue];
		n.location = 6;
		int second = [[string substringWithRange:n] intValue];
		
		v.timeSecond = (hour * 60 * 60) + (minute * 60) + second;
		
		[m.viewScoreKeeper presentModalViewController:v animated:YES];
		[v release];
	} else if ( [cell isKindOfClass:[ColorDataEntryCell class]] ) {
		ColorDataEntryCell *cell1 = (ColorDataEntryCell *) cell;
		[cell1 labelTouch:nil];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	self.vsk = nil;
}


- (void)dealloc {
	[tableStructure release];
	[tableData release];
	[vsk release];
    [super dealloc];
}


@end
