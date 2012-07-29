//
//  ReporterBackendInteraction.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "ReporterBackendInteraction.h"

static NSString *const kBaseAPI = @"http://crowdreporter-johnmarkos.dotcloud.com";
static NSString *const kTokenURL = @"/api/v1/tokens.json";
static NSString *const kReport = @"/reports";

@implementation ReporterBackendInteraction
@synthesize selectedString;


+ (id)sharedManager {
    static ReporterBackendInteraction *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (BOOL) userIsLoggedIn{
    
    if (token != nil){
        return TRUE;
    }
    
    else {
        return FALSE;
    }
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    
    NSError* error = nil;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions error:&error];
    NSLog(@"%@",json);
    
    token = [json objectForKey:@"token"];
    
    if (token != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:token forKey:@"token"];
        
        [defaults synchronize];
    }
    
    else {
        username = nil;
    }
    
}

- (void) authWithUsername:(NSString*)usernames andPassword:(NSString*)password{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[kBaseAPI stringByAppendingString:kTokenURL]]];
    [request setPostValue:usernames forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void) createAReportWithType:(NSString*)type description:(NSString*)description latitude:(NSString*)
latitude longitude:(NSString*) longitude imageURL:(NSString*)image_url live_stream:(NSString*)liveStream{

    NSError *error;
    NSDictionary *report = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",description, @"description", latitude, @"latitude", longitude ,@"longitude", image_url, @"image_url", liveStream, @"live_stream", nil];

    NSDictionary* reportDictionary = [NSDictionary dictionaryWithObjectsAndKeys:token,@"auth_token",report, @"report",nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:reportDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[kBaseAPI stringByAppendingString:kReport]]];
    [request setRequestMethod:@"POST"];
    request.postBody = [NSMutableData dataWithData:jsonData];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (id)init {
    if (self = [super init]) {
        
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"token"] != nil) {
        token = [defaults objectForKey:@"token"];
        NSLog(@"Loading old token");
    }
    
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
