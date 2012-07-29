//
//  LivePortViewController.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Opentok/Opentok.h>

@interface LivePortViewController : UIViewController <OTSessionDelegate, OTPublisherDelegate>{
    UIView *details;
}

- (void)doConnect;
- (void)doPublish;
- (void)showAlert:(NSString*)string;

@end
