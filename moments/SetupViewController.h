//
//  SetupViewController.h
//  moments
//
//  Created by jKool LLC on 6/6/16.
//  Copyright © 2016 jKool LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupViewController : UIViewController {
    IBOutlet UIButton   *setupButton;
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
    IBOutlet UITextField *confirmPassword;
    IBOutlet UITextField *email;
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *lastName;
    IBOutlet UILabel *setupLabel;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UILabel *confirmPasswordLabel;
}
- (IBAction)doneAction:(id)sender;
- (IBAction)save:(id)sender;

@end
