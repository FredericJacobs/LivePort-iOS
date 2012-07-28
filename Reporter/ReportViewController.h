//
//  StorifyReshareViewController.h
//  Storify
//
//  Created by Frederic Jacobs on 25/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>{
    
    IBOutlet UITableView *maintable;
    

}

@property (nonatomic, retain) IBOutlet UITableView *maintable;


@end
