//
//  ViewController.m
//  moments
//
//  Created by jKool LLC on 4/14/16.
//  Copyright jKool LLC. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()



@end

@implementation ViewController {
    //CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSMutableData *responseData;
    CLLocation* location;

    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)viewWillAppear:(BOOL)animated {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss zzz"];
    [locationManager startUpdatingLocation];
    [momentDateTime setText:[formatter stringFromDate:[[NSDate alloc] init]]];
    [momentText setContentOffset:CGPointZero animated:YES];
    momentText.text = @"Enter your moment here ...";
    momentText.editable = YES;
    [super viewWillAppear:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);

}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",str);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}



- (IBAction)remember:(id)sender {
    
    NSString *alertText;
    NSString *tag;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss zzz"];
    [locationManager startUpdatingLocation];
    [momentDateTime setText:[formatter stringFromDate:[[NSDate alloc] init]]];
    if (sender == happyMomentButton)
    {
        alertText = @"Your happy moment has been saved. Please log into www.jkoolcloud.com to see all of your moments.";
        tag = @"happy";
    }
    else
    {
        alertText = @"Your sad moment has been saved. Please log into www.jkoolcloud.com to see all of your moments.";
        tag = @"sad";
    }

    long long millisecondslong = (long long)([[NSDate date] timeIntervalSince1970] * 1000000.0);
    NSNumber* milliseconds = [[NSNumber alloc] initWithLongLong:millisecondslong];
    //NSNumber* milliseconds = [[NSNumber alloc] initWithLongLong:1457524800000000];
    NSString *sourceFqn = [@"APPL=Moments#SERVER=WebServer100#NETADDR=11.0.0.2#DATACENTER=DC1#GEOADDR=" stringByAppendingFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    [locationManager startUpdatingLocation];
    NSArray *objects = [NSArray arrayWithObjects:sourceFqn, @"mymoment", @"EVENT", milliseconds,milliseconds, momentText.text, tag, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"source-fqn", @"operation", @"type", @"start-time-usec",@"end-time-usec", @"msg-text", @"msg-tag", nil];
    NSDictionary *jKoolDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSData *requestData = [NSJSONSerialization  dataWithJSONObject:jKoolDict options:NSJSONWritingPrettyPrinted error:0];
    NSURL *url = [NSURL URLWithString:@"http://test.jkoolcloud.com:6580/jesl/event"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"YOUR-TOKEN" forHTTPHeaderField:@"token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];


    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Moment Saved"
                                  message:alertText
                                  preferredStyle:UIAlertControllerStyleActionSheet
                                  ];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    
    [alert addAction:ok];

    
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
{
    location = [locations lastObject];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            momentLocation.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.locality,placemark.administrativeArea,
                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
        [locationManager stopUpdatingLocation];
    
}}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([momentText isFirstResponder] && [touch view] != momentText) {
        [momentText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextField: textView up: YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextField: textView up: NO];
}

- (void) animateTextField: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait));
}


@end
