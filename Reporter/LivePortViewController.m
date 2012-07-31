//
//  LivePortViewController.m
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import "LivePortViewController.h"
#import "ReporterBackendInteraction.h"
@implementation LivePortViewController {
    OTSubscriber* _subscriber;
    OTSession* _session;
    OTPublisher* _publisher;
}
@synthesize pickerView,details,segmented;
static double widgetHeight = 240;
static double widgetWidth = 320;

// Don't forget to change the API key and token.
// Ideally your back-end should generate a new session key for each new event that is reported. We didn't had time to fully implemented so this was removed in this release.
// You can get yourself these keys here : http://staging.tokbox.com/hl/session/create

static NSString* const kApiKey = @"1127";
static NSString* const kToken = @"devtoken";
static NSString* const kSessionId = @"1sdemo00855f8290f8efa648d9347d718f7e06fd";

static bool subscribeToSelf = NO;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [[[ReporterBackendInteraction sharedManager] categories] count];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateSubscriber {
    for (NSString* streamId in _session.streams) {
        OTStream* stream = [_session.streams valueForKey:streamId];
        if (![stream.connection.connectionId isEqualToString: _session.connection.connectionId]) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
            break;
        }
    }
}

- (void)session:(OTSession*)mySession didReceiveStream:(OTStream*)stream
{
    NSLog(@"session didReceiveStream (%@)", stream.streamId);
    
    // See the declaration of subscribeToSelf above.
    if ( (subscribeToSelf && [stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ||
        (!subscribeToSelf && ![stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ) {
        if (!_subscriber) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
        }
    }
}


- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    NSLog(@"subscriberDidConnectToStream (%@)", subscriber.stream.connection.connectionId);
    [subscriber.view setFrame:CGRectMake(0, 0, widgetWidth, widgetHeight)];
    [subscriber.view setAlpha:1];
    subscriberView = subscriber.view;
    [self.view addSubview:subscriber.view];
}

- (void)showAlert:(NSString*)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message from video session"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)session:(OTSession*)session didDropStream:(OTStream*)stream{
    NSLog(@"session didDropStream (%@)", stream.streamId);
    NSLog(@"_subscriber.stream.streamId (%@)", _subscriber.stream.streamId);
    if (!subscribeToSelf
        && _subscriber
        && [_subscriber.stream.streamId isEqualToString: stream.streamId])
    {
        _subscriber = nil;
        [self updateSubscriber];
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[ReporterBackendInteraction sharedManager] categories] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [[ReporterBackendInteraction sharedManager]setSelectedString:[[[ReporterBackendInteraction sharedManager] categories]objectAtIndex:row]];
    
    [UIView animateWithDuration:0.7
                     animations:^{
                         [pickerView setAlpha:0];
                         [pickerView setTransform:CGAffineTransformMakeTranslation(0, -216.0)];
                     }
                     completion:^(BOOL finished){
                         [pickerView removeFromSuperview];
                     }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    _session = [[OTSession alloc] initWithSessionId:kSessionId
                                           delegate:self];
    [self doConnect];
    
    [self.view addSubview:[[LivePortInfosView alloc]init]];
    
}


- (IBAction)showCategoriesPicker:(id)sender{
    
    [pickerView setFrame:CGRectMake(0, 460, 320,216)];
    
    [self.view addSubview:pickerView];
    
    [UIView animateWithDuration:0.7
                     animations:^{
                         [pickerView setAlpha:1];
                         [pickerView setTransform:CGAffineTransformMakeTranslation(0, -216.0)];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}


- (IBAction)done:(id)sender{
    
    [[self presentingViewController]dismissModalViewControllerAnimated:YES];
}


#pragma mark - OpenTok methods

- (void)doConnect
{
    [_session connectWithApiKey:kApiKey token:kToken];
}

- (void)doPublish
{
    _publisher = [[OTPublisher alloc] initWithDelegate:self];
    [_publisher setName:[[UIDevice currentDevice] name]];
    _publisher.cameraPosition = AVCaptureDevicePositionBack;
    [_session publish:_publisher];
    publisherView = _publisher.view;
    [self.view addSubview:_publisher.view];
    [_publisher.view setFrame:CGRectMake(0, 0, widgetWidth, widgetHeight)];
}

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect (%@)", session.sessionId);
    [self doPublish];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSString* alertMessage = [NSString stringWithFormat:@"Session disconnected: (%@)", session.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
    [self showAlert:alertMessage];
}




- (void)publisher:(OTPublisher*)publisher didFailWithError:(OTError*) error {
    NSLog(@"publisher didFailWithError %@", error);
    [self showAlert:[NSString stringWithFormat:@"There was an error publishing."]];
}

- (void)subscriber:(OTSubscriber*)subscriber didFailWithError:(OTError*)error
{
    NSLog(@"subscriber %@ didFailWithError %@", subscriber.stream.streamId, error);
    [self showAlert:[NSString stringWithFormat:@"There was an error subscribing to stream %@", subscriber.stream.streamId]];
}

- (void)session:(OTSession*)session didFailWithError:(OTError*)error {
    NSLog(@"sessionDidFail");
    [self showAlert:[NSString stringWithFormat:@"There was an error connecting to session %@", session.sessionId]];
}

// Switch for videochatting when 2 iphones or more are connected
// Useful feature to check if your hair is like you want it to be.

-(IBAction) segmentedControlIndexChanged{
	switch (self.segmented.selectedSegmentIndex) {
		case 0:
			[publisherView setAlpha:0];
            [subscriberView setAlpha:1];
            NSLog(@"Me");
			break;
		case 1:
			[publisherView setAlpha:1];
            [subscriberView setAlpha:0];
            NSLog(@"You");
			break;
            
		default:
            break;
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
