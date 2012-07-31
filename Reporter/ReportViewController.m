//
//  StorifyReshareViewController.m
//  Storify
//
//  Created by Frederic Jacobs on 25/7/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportWhatViewController.h"
#import "ReporterBackendInteraction.h"


@interface ReportViewController ()

@end


@implementation ReportViewController

@synthesize maintable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sectionsArray = [NSMutableArray arrayWithObjects: @"What ?",@"Where ?",@"When ?",nil];
        accurateLocation = FALSE;
        pictureURL = [[ReporterBackendInteraction sharedManager]image_url];
        if (pictureURL != nil) {
            [sectionsArray addObject:@"Image"];
        }
    }
    return self;
}

-(void) loadLocation {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (accurateLocation == TRUE) {
        return;
    }
    
    accurateLocation = TRUE;
    
    decLoc = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    [[ReporterBackendInteraction sharedManager] setLastLatitude:decLoc];
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
    
    [[ReporterBackendInteraction sharedManager] setLastLongitude:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude ]];
    
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
    
    if (section == 0) {
        return 2;
    }
    
    if (section == 1) {
        if (accurateLocation) {
            return 1;
        }
    }
    
    if (section == 2) {
        return 2;
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
        if (indexPath.row == 0 ) {
            // Initialize cell
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.textLabel.text = @"Category";
            if (nil == [[ReporterBackendInteraction sharedManager] selectedString]) {
                cell.detailTextLabel.text = @"Pick One";
            }
            else{
                cell.detailTextLabel.text = [[ReporterBackendInteraction sharedManager] selectedString];
            }
            // TODO: Any other initialization that applies to all cells of this type.
            //       (Possibly create and add subviews, assign tags, etc.)
        }
        if (indexPath.row == 1) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportDescription"];
            
            textFieldRounded = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 300, 100)];
            textFieldRounded.textColor = [UIColor blackColor];
            textFieldRounded.font = [UIFont systemFontOfSize:17.0];
            textFieldRounded.placeholder = @"Description";
            textFieldRounded.backgroundColor = [UIColor clearColor];
            textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;
            textFieldRounded.keyboardType = UIKeyboardTypeDefault;
            textFieldRounded.returnKeyType = UIReturnKeyDone;
            textFieldRounded.delegate = self;
            [cell addSubview:textFieldRounded];
            
        }
        
    }
    else if (indexPath.section == 1){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportLocationViewCell"];
        if (!accurateLocation) {
            cell.textLabel.text = @"Location Loading";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        else {
            if (indexPath.row == 0) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportLocationViewCell"];
            
                mapview = [[MKMapView alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
                CLLocationCoordinate2D coord = {.latitude =  [[locationManager location]coordinate].latitude, .longitude =  [[locationManager location]coordinate].longitude};
                MKCoordinateSpan span = {.latitudeDelta =  0.01, .longitudeDelta =  0.01};
                MKCoordinateRegion region = {coord, span};
                mapview.region = region;
                
                MKPointAnnotation *addAnnotation = [[MKPointAnnotation alloc] init];
                addAnnotation.coordinate = coord;
                [mapview addAnnotation:addAnnotation];
                [mapview clipsToBounds];
                [cell clipsToBounds];
                [cell addSubview:mapview];
            
        }
    
    
    }
}

else if (indexPath.section == 2){
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"ReportTimeViewCell"];
    
    NSDate *localDate = [NSDate date];
    
    if (indexPath.row == 0 ) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        
        NSString *dateString = [dateFormatter stringFromDate: localDate];
        cell.textLabel.text = @"Day";
        cell.detailTextLabel.text = dateString;
        cell.textLabel.textAlignment = UITextAlignmentCenter;
                               
    }
    
    if (indexPath.row == 1) {
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"HH:mm:ss";
        
        
        NSString *dateString = [timeFormatter stringFromDate: localDate];
        cell.detailTextLabel.text = dateString;
        cell.textLabel.text = @"Hour";
        cell.textLabel.textAlignment = UITextAlignmentCenter;

    }

}

else if (indexPath.section == 3){
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReportImageViewCell"];
    UIImageView *pict = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 225)];
    [pict setImageWithURL:[NSURL URLWithString:pictureURL]];
    
    [cell addSubview:pict];
    [cell clipsToBounds];
    
}

return cell;
}

- (BOOL) readyToReport {
    
    if ( [[ReporterBackendInteraction sharedManager] selectedString] != nil && textFieldRounded.text != nil){
        return true;
    }
    else{
        return false;
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    [textFieldRounded resignFirstResponder];
    
    if ([self readyToReport]) {
        [[ReporterBackendInteraction sharedManager]setReportDescription:textFieldRounded.text];
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [[self navigationController] pushViewController:[[ReportWhatViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [maintable reloadData];
    if ([self readyToReport]) {
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 1)
            return 100;
    }
    
    if (indexPath.section == 3) {
        return 225;
    }
    
    if (indexPath.section == 1) {
        if (accurateLocation) {
            return 200;
        }
    }
    
    return 44;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
