//
//  StorifyStoriesNavigationViewController.h
//  Storify
//
//  Created by Frederic Jacobs on 26/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportingNavigationViewController : UIViewController{
    
    UINavigationController *navigationController;
    UIBarButtonItem *reportButton;
}

@property (nonatomic,retain) UIBarButtonItem *reportButton;

@end
