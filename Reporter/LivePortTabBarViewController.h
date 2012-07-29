//
//  LivePortTabBarViewController.h
//  LivePort
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LivePortLoginView.h"

@interface LivePortTabBarViewController : UITabBarController{
    UIImageView *defaultView;
    LivePortLoginView *loginView;
    
}

@property (nonatomic, retain) IBOutlet LivePortLoginView *loginView;

@end
