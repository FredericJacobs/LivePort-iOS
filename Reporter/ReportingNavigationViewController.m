//
//  StorifyStoriesNavigationViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 26/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "ReportingNavigationViewController.h"
#import "ReportViewController.h"

@interface ReportingNavigationViewController ()

@end

@implementation ReportingNavigationViewController

- (void)viewDidLoad
{
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    [super viewDidLoad];
    
    ReportViewController *reportingVC = [[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:reportingVC];
    
    reportingVC.title = @"Report";
    
    UIBarButtonItem *dismissButton=[[UIBarButtonItem alloc]
                               initWithTitle:@"Dismiss" style:UIBarButtonItemStyleBordered
                               target:self action:@selector(dismissMVC)];

    
    reportingVC.navigationItem.leftBarButtonItem = dismissButton ;
    
    [self.view addSubview:navigationController.view];

}

- (void) dismissMVC {
    [self ]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
