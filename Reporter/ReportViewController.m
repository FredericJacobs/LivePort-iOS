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

#define sectionsArray [NSArray arrayWithObjects: @"What ?",@"Where ?",@"When ?",@"Tell Us More",nil]

@implementation ReportViewController

@synthesize maintable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        accurateLocation = FALSE;
    }
    return self;
}

-(void) loadLocation {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    accurateLocation = TRUE;
    
    decLoc = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    latitude = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    
    decLoc = [[NSString stringWithString:decLoc] stringByAppendingString:[NSString stringWithFormat:@",%f",newLocation.coordinate.longitude ]];
    
    longitude = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    
    [maintable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLocation];
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [sectionsArray count];

}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [sectionsArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        if (accurateLocation) {
            return 3;
        }
    }
    
    if (section == 3) {
        return 1;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportTableViewCell"];
    if (cell == nil) {
        // No cell to reuse => create a new one
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"ReportTableViewCell"];
        
    }
    if (indexPath.section == 0 ) {
        // Initialize cell
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.text = @"Category";
        cell.detailTextLabel.text = nil;
        // TODO: Any other initialization that applies to all cells of this type.
        //       (Possibly create and add subviews, assign tags, etc.)
    }
    else if (indexPath.section == 1){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportLocationViewCell"];
        if (!accurateLocation) {
            cell.textLabel.text = @"Location Loading";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        else {
            if (indexPath.row == 0) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"ReportLocationViewCell"];

                cell.textLabel.text = @"Latitude";
                cell.detailTextLabel.text = latitude;
            }
            
            if (indexPath.row == 1) {
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"ReportLocationViewCell"];
                cell.textLabel.text = @"Longitude";
                cell.detailTextLabel.text = longitude;
            }
            
            if (indexPath.row == 2) {
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.text = @"Map It";

            }

        }
        
    }
    
    else if (indexPath.section == 2){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportTimeViewCell"];
        cell.textLabel.text = [[[NSDate alloc] init] descriptionWithLocale:[NSLocale currentLocale]];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    else if (indexPath.section == 3) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportDescription"];
        
        UITextField *textFieldRounded = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 300, 100)];
        textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
        textFieldRounded.textColor = [UIColor blackColor];
        textFieldRounded.font = [UIFont systemFontOfSize:17.0];
        textFieldRounded.placeholder = @"Enter Your name";  //place holder
        textFieldRounded.backgroundColor = [UIColor whiteColor];
        textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldRounded.keyboardType = UIKeyboardTypeDefault;
        textFieldRounded.returnKeyType = UIReturnKeyDone;
        textFieldRounded.delegate = self;
        
        [cell addSubview:textFieldRounded];
    }
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [[self navigationController] pushViewController:[[ReportWhatViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
   
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            UIApplication *app = [UIApplication sharedApplication];
            NSString *coordinates = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
            NSLog(@"%@",coordinates);
            [app openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",decLoc]]];
        }
    }
    
}

- (void) viewWillAppear:(BOOL)animated{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 100;
    }
    
    return 44;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
