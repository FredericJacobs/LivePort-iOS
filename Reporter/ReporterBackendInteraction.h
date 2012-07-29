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
    NSString *image_url;
    NSArray *categories;
    NSString *lastLatitude;
    NSString *lastLongitude;
    NSString *reportDescription;
}

@property (nonatomic,retain) NSString *selectedString;
@property (nonatomic,retain) NSString *image_url;
@property (nonatomic,readonly) NSString *username;
@property (nonatomic,readonly) NSArray *categories;
@property (nonatomic,retain) NSString *reportDescription;
@property (readwrite) NSString *lastLatitude;
@property (readwrite) NSString *lastLongitude;

+ (id)sharedManager;
- (BOOL) authWithUsername:(NSString*)usernames andPassword:(NSString*)password;
- (BOOL) userIsLoggedIn;
- (void) createAReport;


@end
