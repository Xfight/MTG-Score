//
//  GoogleAdsViewController.m
//  MTG Score
//
//  Created by Luca Bertani on 15/05/11.
//  Copyright 2011 home. All rights reserved.
//

#import "GoogleAdsViewController.h"


@implementation GoogleAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"w : %f, h : %f", self.view.frame.size.width, self.view.frame.size.height);
    
    // Create a view of the standard size at the bottom of the screen.
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;

    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a14d70a3e5408ca";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    bannerView_.delegate = self;
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,                               // Simulator
                           nil];
    
    // Initiate a generic request to load it with an ad.
    //[bannerView_ loadRequest:[GADRequest request]];
    [bannerView_ loadRequest:request];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [UIView beginAnimations:@"BannerSlide" context:nil];
    bannerView.frame = CGRectMake(0.0,
                                  self.view.frame.size.height -
                                  bannerView.frame.size.height,
                                  bannerView.frame.size.width,
                                  bannerView.frame.size.height);
    [UIView commitAnimations];
    
    NSLog(@"Banner received !!!");
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
}

- (void)viewDidUnload {
    [bannerView_ release];
}

- (void)dealloc {
    [super dealloc];
}

@end
