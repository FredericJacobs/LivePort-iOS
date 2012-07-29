//
//  StorifyReshareViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 25/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end


@implementation ReportViewController

@synthesize maintable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportTableViewCell"];
    if (cell == nil) {
        // No cell to reuse => create a new one
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportTableViewCell"];
        
        // Initialize cell
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor blueColor];
        // TODO: Any other initialization that applies to all cells of this type.
        //       (Possibly create and add subviews, assign tags, etc.)
    }
    
    cell.textLabel.text = @"Placeholder";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
