//
//  Connection.h
//  SiteCheck
//
//  Created by Luca on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@interface MyConnection : NSObject {
	
}

+ (BOOL) isConnected;
+ (NSString *)retrieveDataFromUrl:(NSURL *)url;

@end

