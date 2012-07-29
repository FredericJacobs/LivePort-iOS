//
//  LivePortTabBarViewController.m
//  LivePort
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "LivePortTabBarViewController.h"
#import "ReporterBackendInteraction.h"
@interface LivePortTabBarViewController ()

@end

@implementation LivePortTabBarViewController
@synthesize loginView;

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
    
    if (![[ReporterBackendInteraction sharedManager]userIsLoggedIn]) {
        loginView = [[LivePortLoginView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        
        loginView.usernameField = [[UITextField alloc]initWithFrame:CGRectMake(50, 260, 260, 30)];
        loginView.mPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(50, 315, 260, 30)];
        
        
        loginView.usernameField.placeholder = @"Username";
        [loginView.usernameField setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [loginView.usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [loginView.usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        loginView.usernameField.textColor = [UIColor whiteColor];
        loginView.usernameField.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        loginView.usernameField.userInteractionEnabled = YES;
        loginView.usernameField.delegate = self;
        loginView.usernameField.returnKeyType=UIReturnKeyNext;
        
        
        [loginView.mPasswordField setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [loginView.mPasswordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [loginView.mPasswordField setAutocorrectionType:UITextAutocorrectionTypeNo];
        loginView.mPasswordField.textColor = [UIColor whiteColor];
        loginView.mPasswordField.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        loginView.mPasswordField.placeholder = @"Password";
        loginView.mPasswordField.secureTextEntry = YES;
        loginView.mPasswordField.userInteractionEnabled = YES;
        loginView.mPasswordField.delegate = self;
        
        
        [loginView addSubview:loginView.usernameField];
        [loginView addSubview:loginView.mPasswordField];

        
        [self.view addSubview:loginView];
    }
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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationsEnabled:YES];
    CGRect frame = CGRectMake(0, -130, loginView.frame.size.width, loginView.frame.size.height);
    [loginView setFrame:frame];
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationsEnabled:YES];
    CGRect frame = CGRectMake(0, 0, loginView.frame.size.width, loginView.frame.size.height);
    [loginView setFrame:frame];
    [UIView commitAnimations];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //If we hit return in the email field, just activate the password field
    if(textField == loginView.usernameField)
    {
        [textField resignFirstResponder];
        [loginView.mPasswordField becomeFirstResponder];
        
        return YES;
        
    }
    
    else if (textField ==loginView.mPasswordField)
    {
        [textField resignFirstResponder];
        [self login];
        return YES;
        
    }
    return TRUE;
}


- (void) login {
    
    if (![[ReporterBackendInteraction sharedManager] authWithUsername:loginView.usernameField.text andPassword:loginView.mPasswordField.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Login Failed"
                              message: @"If you don't have an account, sign up on the website"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    else {
        [UIView animateWithDuration:1.8 delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^
         {
             loginView.alpha = 0.0f;
             
         } completion:^(BOOL finished)
         {
             [loginView removeFromSuperview];
         }];

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
