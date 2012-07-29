//
//  LivePortTabBarViewController.m
//  LivePort
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "LivePortTabBarViewController.h"

@interface LivePortTabBarViewController ()

@end

@implementation LivePortTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
}
    return self;
}

- (void)fadeOut
{
    
    [UIView animateWithDuration:1.8 delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^
     {
         defaultView.alpha = 0.0f;
         
     } completion:^(BOOL finished)
     {
         [defaultView removeFromSuperview];
     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void) viewWillAppear:(BOOL)animated{
    AppDelegate  *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate animatedLaunch]){
        defaultView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default.png"]];
        defaultView.frame = [[UIScreen mainScreen]bounds];
        [self.view addSubview:defaultView];
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(fadeOut) userInfo:nil repeats:NO];
        [appDelegate reverseAnimatedLaunch];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
