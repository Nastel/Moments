/*
 * Copyright (c) 2016 jKool, LLC. All Rights Reserved.
 *
 * This software is the confidential and proprietary information of
 * jKool, LLC. ("Confidential Information").  You shall not disclose
 * such Confidential Information and shall use it only in accordance with
 * the terms of the license agreement you entered into with jKool, LLC.
 *
 * JKOOL MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
 * THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE, OR NON-INFRINGEMENT. JKOOL SHALL NOT BE LIABLE FOR ANY DAMAGES
 * SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING OR DISTRIBUTING
 * THIS SOFTWARE OR ITS DERIVATIVES.
 *
 * CopyrightVersion 1.0
 *
 */

#import "ViewController.h"
#import "jKoolStreaming.h"
#import "jkCallbackHandlerStreaming.h"
#import "jkProperty.h"
#import "jkLocation.h"


@interface ViewController ()

@end

@implementation ViewController {
    jKoolStreaming *jkStreaming ;
    NSString *tag;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize xlocation = _xlocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get the token user obtained upon registering
    NSUserDefaults *appPrefs = [[NSUserDefaults alloc] init];
    // Initialize streaming and specify callback handler.
    NSObject *cbStream = [[jkCallbackHandlerStreaming alloc] initWithViewController:self];
    jkStreaming = [[jKoolStreaming alloc] init];
    NSString *token = [appPrefs objectForKey:@"token"];
    [jkStreaming setToken:token];
    [jkStreaming initializeStream:cbStream];
    geocoder = [[CLGeocoder alloc]init];
    
    // Kick-off locationing
    _xlocation = [[jkLocation alloc] init];
    [_xlocation kickOffLocationing];
}

- (void)viewWillAppear:(BOOL)animated {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss zzz"];
    [momentDateTime setText:[formatter stringFromDate:[[NSDate alloc] init]]];
    [momentText setContentOffset:CGPointZero animated:YES];
    momentText.text = @"Enter your moment here ...";
    momentText.editable = YES;
    

    
   // momentLocation.text = _xlocation.getCoordinates;
    [super viewWillAppear:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remember:(id)sender {
    
    [self stream];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss zzz"];
    [momentDateTime setText:[formatter stringFromDate:[[NSDate alloc] init]]];
    if (sender == happyMomentButton)
    {
        tag = @"happy";
    }
    else
    {
        tag = @"sad";
    }
}

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

- (void)stream {
    // Stream Event with snapshot and properties
    jkEvent *event = [[jkEvent alloc] initWithName:@"mymoment"];
    [event setMsgText:momentText.text] ;
    [event setGeoAddr:[_xlocation getCoordinates]];
    [event setMsgTag:tag];
    [jkStreaming stream:event forUrl:@"event"];
    
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:[_xlocation detectedLocation] completionHandler:^(NSArray *placemarks, NSError *error) {
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
    
    
    
    
}

@end
