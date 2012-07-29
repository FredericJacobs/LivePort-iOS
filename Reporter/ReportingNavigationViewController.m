//
//  StorifyStoriesNavigationViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 26/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "ReportingNavigationViewController.h"
#import "ReportViewController.h"
#import "ReporterBackendInteraction.h"

@interface ReportingNavigationViewController ()

@end

@implementation ReportingNavigationViewController
@synthesize reportButton;
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
    
    reportButton=[[UIBarButtonItem alloc]
                                    initWithTitle:@"Report" style:UIBarButtonItemStyleDone
                                    target:self action:@selector(report)];

    reportButton.enabled = false;
    
    reportingVC.navigationItem.leftBarButtonItem = dismissButton ;
    reportingVC.navigationItem.rightBarButtonItem = reportButton ;
    
    [self.view addSubview:navigationController.view];

}

- (void) report{
    
    [[ReporterBackendInteraction sharedManager]createAReport];
    
}

- (void) dismissMVC {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
