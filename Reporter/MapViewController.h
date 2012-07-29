//
//  FirstViewController.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController  : UIViewController <UIWebViewDelegate>{
    UIWebView *map;
}

@property (nonatomic,retain) UIWebView *map;

@end
