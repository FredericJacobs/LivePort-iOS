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
        
        ReportingNavigationViewController *reporting = [[ReportingNavigationViewController alloc]init] ;
        
        [self presentViewController:reporting animated:YES completion:nil];
		
	} else if (buttonIndex == 1) {
        FPPickerController *fpController = [[FPPickerController alloc] init];
        
        fpController.sourceNames = [[NSArray alloc] initWithObjects: FPSourceCamera, FPSourceCameraRoll, nil];
        
        fpController.fpdelegate = self;
        
        
        [self presentModalViewController:fpController animated:YES];
	}
    
    else if (buttonIndex == 2){
        
        LivePortViewController *livePort = [[LivePortViewController alloc] init];
        
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
    [[ReporterBackendInteraction sharedManager] setPictureURL:[info objectForKey:@"FPPickerControllerRemoteURL"]];
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        ReportingNavigationViewController *reporting = [[ReportingNavigationViewController alloc]init] ;
        
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
