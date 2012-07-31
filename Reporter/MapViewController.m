//
//  FirstViewController.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import "MapViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController
@synthesize map;

- (void)viewDidLoad
{
    [super viewDidLoad];
    map = [[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.view addSubview:map];
    [map setDelegate:self];
    
    NSString *urlAddress = @"http://crowdreporter-johnmarkos.dotcloud.com/mobile.html";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [map loadRequest:requestObj];
    
}

- (void)viewDidAppear:(BOOL)animated{    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
