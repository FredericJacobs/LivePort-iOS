//
//  StorifyReshareViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 25/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportWhatViewController.h"

@interface ReportViewController ()

@end

#define sectionsArray [NSArray arrayWithObjects: @"What ?",@"Where ?",@"When ?",nil]

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
    
    return [sectionsArray count];

}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [sectionsArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportTableViewCell"];
    if (cell == nil) {
        // No cell to reuse => create a new one
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"ReportTableViewCell"];
        
        // Initialize cell
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"Select";
        // TODO: Any other initialization that applies to all cells of this type.
        //       (Possibly create and add subviews, assign tags, etc.)
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[self navigationController] pushViewController:[[ReportWhatViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
