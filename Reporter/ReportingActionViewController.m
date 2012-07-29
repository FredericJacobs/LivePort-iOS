//
//  SecondViewController.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "SecondViewController.h"
#import "ReporterBackendInteraction.h"
#import "ReportingNavigationViewController.h"
#import "LivePortViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController 

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
    // Release any retained subviews of the main view.
}



-(IBAction)showActionSheet:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Report", @"Take a shot", @"LivePort", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        
        ReportingNavigationViewController *reporting = [[ReportingNavigationViewController alloc]init] ;
        
        [self presentViewController:reporting animated:YES completion:nil];
		
	} else if (buttonIndex == 1) {
        FPPickerController *fpController = [[FPPickerController alloc] init];
        
        // Select and order the sources (Optional) Default is all sources
        fpController.sourceNames = [[NSArray alloc] initWithObjects: FPSourceCamera, FPSourceCameraRoll, nil];
        
        fpController.fpdelegate = self;
        
        
        [self presentModalViewController:fpController animated:YES];
	}
    
    else if (buttonIndex == 2){
        
        LivePortViewController *livePort = [[LivePortViewController alloc] init];
        
        [self presentModalViewController:livePort animated:YES];
        
    }
    
}

- (void) FPPickerController:(FPPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [[ReporterBackendInteraction sharedManager] sendImageURLToBackend:[info objectForKey:@"FPPickerControllerRemoteURL"]];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) FPPickerControllerDidCancel:(FPPickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
