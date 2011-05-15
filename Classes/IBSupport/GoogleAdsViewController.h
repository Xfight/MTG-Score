//
//  GoogleAdsViewController.h
//  MTG Score
//
//  Created by Luca Bertani on 15/05/11.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
// BannerExampleViewController.h

// Import GADBannerView’s definition from the SDK
#import "GADBannerView.h"

@interface GoogleAdsViewController : UIViewController <GADBannerViewDelegate> {
    // Declare one as an instance variable
    GADBannerView *bannerView_;
}

@end
