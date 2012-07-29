//
//  StorifyReshareViewController.h
//  Storify
//
//  Created by Frederic Jacobs on 25/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ReportViewController : UIViewController <UITableViewDataSource, UITableViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate>{
    CLLocationManager *locationManager;
    IBOutlet UITableView *maintable;
    NSString *latitude;
    NSString *longitude;
    NSString *decLoc;
    BOOL accurateLocation;
    UITextField *textFieldRounded;
}

@property (nonatomic, retain) IBOutlet UITableView *maintable;


@end
