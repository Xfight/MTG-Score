//
//  ColorDataChoose.h
//  MTG SK
//
//  Created by Luca on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kColorRed	1
#define kColorGreen	2
#define kColorBlack	3
#define kColorBlue	4
#define kColorWhite	5
#define kColorTable	6

@interface ColorDataChoose : UIViewController {
	UIView *viewColor;
	
	UISlider *sliderRed;
	UISlider *sliderGreen;
	UISlider *sliderBlue;
	UISlider *sliderAlpha;
	
	UIColor *colorForViewBackground;
	BOOL groupTableColor;
	
	id colorDataEntryCell;
}

@property (nonatomic, retain) IBOutlet UIView *viewColor;

@property (nonatomic, retain) IBOutlet UISlider *sliderRed;
@property (nonatomic, retain) IBOutlet UISlider *sliderGreen;
@property (nonatomic, retain) IBOutlet UISlider *sliderBlue;
@property (nonatomic, retain) IBOutlet UISlider *sliderAlpha;

@property (nonatomic, retain) UIColor *colorForViewBackground;
@property (nonatomic) BOOL groupTableColor;
@property (nonatomic, retain) id colorDataEntryCell;

- (IBAction)changeColorFromButton:(UIButton *)sender;
- (IBAction)changeColorFromSlider:(UISlider *)sender;

- (IBAction)cancelButton:(UIBarItem *)sender;
- (IBAction)doneButton:(UIBarItem *)sender;

@end
