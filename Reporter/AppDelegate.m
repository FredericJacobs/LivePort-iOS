//
//  AppDelegate.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "AppDelegate.h"
#import "ReporterBackendInteraction.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    animatedLaunch = TRUE;
    
    if([[ReporterBackendInteraction sharedManager]userIsLoggedIn]){
        [[ReporterBackendInteraction sharedManager]createAReportWithType:@"sniper" description:@"Yet ANother Sniper" latitude:@"0000000" longitude:@"0000" imageURL:nil live_stream:nil];
    }
    else{
        [[ReporterBackendInteraction sharedManager]authWithUsername:@"fred" andPassword:@"fj326400"];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
 
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) animatedLaunch{

    return animatedLaunch;
}

- (void) reverseAnimatedLaunch{
    
    animatedLaunch = FALSE;
}

@end
