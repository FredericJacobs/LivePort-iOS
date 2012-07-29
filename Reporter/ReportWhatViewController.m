//
//  StorifyStoriesTableViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 26/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "StorifyStoriesTableViewController.h"
#import "StorifyAppDelegate.h"
#import "StorifyReshareViewController.h"
#import "StorifyConnect.h"


@interface StorifyStoriesTableViewController ()

@end

@implementation StorifyStoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
    
        userStories = [[StorifyConnect sharedManager] userStories];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{  
    return 1;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"My Stories";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userStories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoryCells";
    [self.tableView registerClass:(Class) [UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[userStories objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[StorifyConnect sharedManager]setSelectedRow:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
