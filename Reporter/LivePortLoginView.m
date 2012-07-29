//
//  LivePortLoginView.m
//  LivePort
//
//  Created by Frederic Jacobs on 29/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "LivePortLoginView.h"

@implementation LivePortLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *loginBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBackground.png"]];
        [self addSubview:loginBackground];
        
        usernameField = [[UITextField alloc]initWithFrame:CGRectMake(50, 260, 260, 20)];
        mPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(50, 315, 260, 20)];
        
        
        usernameField.placeholder = @"Username";
        [usernameField setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        usernameField.textColor = [UIColor whiteColor];
        usernameField.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        usernameField.userInteractionEnabled = YES;
        usernameField.delegate = self;
        usernameField.returnKeyType=UIReturnKeyNext;
        
        
        [mPasswordField setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [mPasswordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [mPasswordField setAutocorrectionType:UITextAutocorrectionTypeNo];
        mPasswordField.textColor = [UIColor whiteColor];
        mPasswordField.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        mPasswordField.placeholder = @"Password";
        mPasswordField.secureTextEntry = YES;
        mPasswordField.userInteractionEnabled = YES;
        mPasswordField.delegate = self;
        
        
        [self addSubview:usernameField];
        [self addSubview:mPasswordField];
    }
    return self;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationsEnabled:YES];
    CGRect frame = CGRectMake(0, -130, self.frame.size.width, self.frame.size.height);
    [self setFrame:frame];
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationsEnabled:YES];
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self setFrame:frame];
    [UIView commitAnimations];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //If we hit return in the email field, just activate the password field
    if(textField == usernameField)
    {
        [textField resignFirstResponder];
        [mPasswordField becomeFirstResponder];
                
        return YES;
        
    }
    
    else if(textField == mPasswordField)
    {
        [textField resignFirstResponder];
        
        [self login];
        
        return YES;
    }
    
    return YES;
}

- (BOOL) login {
    
    return FALSE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
