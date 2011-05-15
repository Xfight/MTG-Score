//
//  Connection.m
//  SiteCheck
//
//  Created by Luca on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyConnection.h"

@implementation MyConnection

+ (BOOL) isConnected {
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        //NSLog(@"Error. Could not recover network reachability flags");
		return NO;
    }
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"];
	NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
	NSURLConnection *testConnection = [[[NSURLConnection alloc] initWithRequest:testRequest delegate:self] autorelease];
	return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

+ (NSString *)retrieveDataFromUrl:(NSURL *)url {
	NSString *s = [NSString stringWithContentsOfURL:url encoding:1 error:NULL];
	return s;
}

@end
