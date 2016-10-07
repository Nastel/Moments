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
