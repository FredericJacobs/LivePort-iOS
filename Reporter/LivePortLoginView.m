//
//  LivePortLoginView.m
//  LivePort
//
//  Created by Frederic Jacobs on 29/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import "LivePortLoginView.h"
#import "ReporterBackendInteraction.h"

@implementation LivePortLoginView
@synthesize mPasswordField,usernameField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *loginBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBackground.png"]];
        [self addSubview:loginBackground];
        
    }
    return self;
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
