//
//  SecondViewController.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FPPicker/FPPicker.h>
#import "ReportingNavigationViewController.h"

@interface ReportingActionViewController : UIViewController <UIActionSheetDelegate, FPPickerDelegate>{
    ReportingNavigationViewController *reporting;
}

@end
