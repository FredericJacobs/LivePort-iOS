//
//  LivePortLoginView.h
//  LivePort
//
//  Created by Frederic Jacobs on 29/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivePortLoginView : UIView {
    UITextField *usernameField;
    UITextField *mPasswordField;
}

@property (nonatomic,retain) UITextField *usernameField;
@property (nonatomic,retain) UITextField *mPasswordField;


@end
