//
//  ViewController.h
//  moments
//
//  Created by jKool LLC on 4/14/16.
//  Copyright © 2016 jKool LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "jkLocation.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UIButton *happyMomentButton;
    IBOutlet UIButton *sadMomentButton;
    IBOutlet UILabel *momentLocation;
    IBOutlet UILabel *momentDateTime;
    IBOutlet UITextView *momentText;
}

@property (retain, nonatomic) jkLocation * xlocation;
- (IBAction)remember:(id)sender;

@end

