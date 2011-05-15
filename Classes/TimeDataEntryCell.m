//
//  TimeDataEntryCell.m
//  MTG SK
//
//  Created by Luca on 17/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeDataEntryCell.h"

@implementation TimeDataEntryCell

@synthesize label;

- (void)labelTouch:(id)sender
{
	//[self postEndEditingNotification];
	
	TimeDataChoose *v = [[TimeDataChoose alloc] init];
	v.timeDataEntryCell = self;
	
	NSString *string = [self.label titleForState:UIControlStateNormal];
	NSRange n;
	n.location = 0;
	n.length = 2;
	
	int hour = [[string substringWithRange:n] intValue];
	n.location = 3;
	int minute = [[string substringWithRange:n] intValue];
	n.location = 6;
	int second = [[string substringWithRange:n] intValue];
	
	v.timeSecond = (hour * 60 * 60) + (minute * 60) + second;
	
    [self.superViewController presentModalViewController:v animated:YES];
	[v release];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {	
		// Configuro il textfield secondo la necessità
		/*self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
		self.textField.clearsOnBeginEditing = NO;
		self.textField.textAlignment = UITextAlignmentLeft;
		self.textField.returnKeyType = UIReturnKeyDone;
		self.textField.font = [UIFont systemFontOfSize:14];		
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.textField.delegate = self;*/
		
		self.label = [UIButton buttonWithType:UIButtonTypeCustom];
		
		[self.label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		self.label.contentEdgeInsets = UIEdgeInsetsMake(0.0, 71.0, 0.0, 0.0);
		
		
		
		//NSArray *arr = [DataAccess objectForKey:@"reverseTime"];
		
		//[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:40], [NSNumber numberWithInt:0],nil]
		//NSLog(@"number %d", [arr objectAtIndex:0]);
		
		//[self.label addTarget:self action:@selector(labelTouch:)forControlEvents:UIControlEventTouchUpInside];
		[self.label addTarget:self action:@selector(labelTouch:)forControlEvents:UIControlEventTouchDown];

		/*[self.label setTitle: @"Hello..."
					forState: UIControlStateNormal];*/
		
		[self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// La label occupaupa il 35% del container
	CGRect labelRect = CGRectMake(self.textLabel.frame.origin.x, 
								  self.textLabel.frame.origin.y, 
								  self.contentView.frame.size.width * .35, 
								  self.textLabel.frame.size.height);
	[self.textLabel setFrame:labelRect];
	
	// Rect area del textbox
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING, 
							 12.0, 
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING, 
							 25.0);
	
	[label setFrame:rect];
}

/*- (void)savePersistence {
	
	NSString *string = [self.label titleForState:UIControlStateNormal];
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
	[DataAccess forseSync];
}*/

- (void)setValueAndNotify:(id)value
{
	// il value passato è un tempo già formattato come stringa
	
	[self.label setTitle: value
				forState: UIControlStateNormal];
	
	[self postEndEditingNotification];
}

- (void)setControlValue:(id)value
{
	// il value passato è un tempo già formattato come stringa
	
	[self.label setTitle: value
				forState: UIControlStateNormal];
}

- (id)getControlValue
{
	//return self.textField.text;
	return [self.label titleForState:UIControlStateNormal];
}

- (void)dealloc {
	self.label = nil;
	[label release];
	[date release];
    [super dealloc];
}

@end