//
//  ReporterBackendInteraction.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "asi-http-request/Classes/ASIFormDataRequest.h"
#import "ReportingNavigationViewController.h"

@interface ReporterBackendInteraction : NSObject <ASIHTTPRequestDelegate>{
    NSString *selectedString;
    NSString *token;
    NSString *username;
    NSString *pictureURL;
    NSArray *categories;
}

@property (nonatomic,retain) NSString *selectedString;
@property (nonatomic,retain) NSString *pictureURL;
@property (nonatomic,readonly) NSString *username;
@property (nonatomic,readonly) NSArray *categories;

+ (id)sharedManager;
- (void) authWithUsername:(NSString*)usernames andPassword:(NSString*)password;
- (BOOL) userIsLoggedIn;
- (void) createAReportWithType:(NSString*)type description:(NSString*)description latitude:(NSString*)latitude longitude:(NSString*) longitude imageURL:(NSString*)image_url live_stream:(NSString*)liveStream;


@end
