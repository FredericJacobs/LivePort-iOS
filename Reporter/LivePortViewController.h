//
//  LivePortViewController.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  Copyright (c) 2012 Telecomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Opentok/Opentok.h>
#import "LivePortInfosView.h"

@interface LivePortViewController : UIViewController <OTSessionDelegate, OTPublisherDelegate, UIPickerViewDelegate, UIPickerViewDataSource, OTSubscriberDelegate>{
    IBOutlet LivePortInfosView *details;
    IBOutlet UIPickerView *pickerView;
    UIView *subscriberView;
    UIView *publisherView;
    IBOutlet UISegmentedControl *segmented;
}
@property (nonatomic,retain) LivePortInfosView *details;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmented;

-(IBAction) segmentedControlIndexChanged;

- (void)doConnect;
- (void)doPublish;
- (void)showAlert:(NSString*)string;

@end
