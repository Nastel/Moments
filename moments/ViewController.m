//
//  ViewController.m
//  moments
//
//  Created by jKool LLC on 4/14/16.
//  Copyright jKool LLC. All rights reserved.
//

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
}
@synthesize xlocation = _xlocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize streaming and specify callback handler.
    NSObject *cbStream = [[jkCallbackHandlerStreaming alloc] initWithViewController:self];
    jkStreaming = [[jKoolStreaming alloc] init];
    [jkStreaming setToken:@"your-token"];
    [jkStreaming initializeStream:cbStream];
    
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
    //[event setGeoAddr:[_xlocation getCoordinates]];
    [event setMsgTag:tag];
    [jkStreaming stream:event forUrl:@"event"];
}

@end
