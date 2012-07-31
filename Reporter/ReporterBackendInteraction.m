//
//  ReporterBackendInteraction.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import "ReporterBackendInteraction.h"


// This is the staging server for #Hack4Change -- Feel free to use your own
// Code available at https://github.com/TelecomixSyria/Reporter

static NSString *const kBaseAPI = @"http://crowdreporter-johnmarkos.dotcloud.com";
static NSString *const kTokenURL = @"/api/v1/tokens.json";
static NSString *const kReport = @"/reports";

@implementation ReporterBackendInteraction
@synthesize selectedString, categories,reportDescription, lastLatitude, lastLongitude,image_url,username;


+ (id)sharedManager {
    static ReporterBackendInteraction *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void) updateCategories {
    
    // Broken
    
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
    
    if ([json objectForKey:@"created_at"] != nil) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"SuccessfulPosting"
         object:self];
    }
    
    else{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"FailedPosting"
         object:self];
    }
    
}

- (void) createAReport{
    
    [self createAReportWithType:selectedString description:reportDescription latitude:lastLatitude longitude:lastLongitude image:image_url live_stream:nil];
    
}


- (BOOL) authWithUsername:(NSString*)usernames andPassword:(NSString*)password{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[kBaseAPI stringByAppendingString:kTokenURL]]];
    [request setPostValue:usernames forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *responseData = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions error:&error];
        
        token = [json objectForKey:@"token"];
        
        if (token != nil) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:token forKey:@"token"];
            [defaults setObject:usernames forKey:@"username"];
            [defaults synchronize];
            return true;
        }
        
        else {
            username = nil;
            token = nil;
            return false;
        }
        
        
    }
    
    return false;
    
}

- (void) createAReportWithType:(NSString*)type description:(NSString*)description latitude:(NSString*)
latitude longitude:(NSString*) longitude image:(NSString*)images_url live_stream:(NSString*)liveStream{
    
    NSError *error;
    NSDictionary *report = [NSDictionary dictionaryWithObjectsAndKeys:type,@"report_type",description, @"description", latitude, @"latitude", longitude ,@"longitude", images_url, @"image_url", liveStream, @"live_stream", nil];
    
    NSDictionary* reportDictionary = [NSDictionary dictionaryWithObjectsAndKeys:token,@"auth_token",report, @"report",nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:reportDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[kBaseAPI stringByAppendingString:kReport]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    request.postBody = [NSMutableData dataWithData:jsonData];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    // Sorry for hardcoding categories, API endpoint broke before demo
    
    categories = @[@"Road Block", @"Checkpoint", @"Police Sighting", @"Fire", @"Earthquake", @"Other" ];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"token"] != nil) {
        token = [defaults objectForKey:@"token"];
        NSLog(@"%@",token);
    }
    
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
