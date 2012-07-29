//
//  SecondViewController.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "ReportingActionViewController.h"
#import "ReporterBackendInteraction.h"
#import "ReportingNavigationViewController.h"
#import "LivePortViewController.h"

@interface ReportingActionViewController ()

@end

@implementation ReportingActionViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successfulPosting:)
                                                 name:@"SuccessfulPosting"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(failedPosting:)
                                                 name:@"FailedPosting"
                                               object:nil];
}

- (void) successfulPosting:(NSNotification *) notification
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         [reporting dismissModalViewControllerAnimated:YES];
                     }
                     completion:^(BOOL finished){
                         [self goBackToTheMapView];
                         [reporting removeFromParentViewController];
                }];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Thanks for reporting !"
                          message: @"This is now for the whole world to see"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
    
    
}

- (void) failedPosting:(NSNotification *) notification
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         [reporting dismissModalViewControllerAnimated:YES];
                     }
                     completion:^(BOOL finished){
                         [self goBackToTheMapView];
                         [reporting removeFromParentViewController];
                     }];
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Posting Failed"
                          message: @"We are sorry to hear that. Try again later."
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];

    
        
}



- (void) viewDidAppear:(BOOL)animated{
    
    [self showActionSheet:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}



-(IBAction)showActionSheet:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Report", @"Take a shot", @"Live Stream", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        
        reporting = [[ReportingNavigationViewController alloc]init] ;
        
        [self presentViewController:reporting animated:YES completion:nil];
		
	} else if (buttonIndex == 1) {
        FPPickerController *fpController = [[FPPickerController alloc] init];
        
        fpController.sourceNames = [[NSArray alloc] initWithObjects: FPSourceCamera, FPSourceCameraRoll, nil];
        
        fpController.fpdelegate = self;
        
        
        [self presentModalViewController:fpController animated:YES];
	}
    
    else if (buttonIndex == 2){
        
        LivePortViewController *livePort = [[LivePortViewController alloc] initWithNibName:@"LivePortInfosViewController" bundle:nil];
        
        [self presentModalViewController:livePort animated:YES];
        
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self goBackToTheMapView ];
}

- (void) goBackToTheMapView{
    self.tabBarController.selectedViewController
    = [self.tabBarController.viewControllers objectAtIndex:0];
}

- (void) FPPickerController:(FPPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [[ReporterBackendInteraction sharedManager] setImage_url:[info objectForKey:@"FPPickerControllerRemoteURL"]];

    [self dismissViewControllerAnimated:YES completion:^(void){
        reporting = [[ReportingNavigationViewController alloc]init] ;
        
    [self presentViewController:reporting animated:YES completion:nil];
    }];;
}

- (void) FPPickerControllerDidCancel:(FPPickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
    [self goBackToTheMapView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
