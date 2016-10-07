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

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helpText.text = @"Welcome to jKools Moments app. This app demonstrates streaming data to a jKool Repository. To use this app you must first register an account in jKool. To do this, simply go to the jKool Account Screen. Enter your information and save. This will create a jKool account for you and store your access token on your device. If you ever delete the app off of your device, you will need to re-register. After registering, you can begin entering your moments. Click the happy face to enter a happy moment and the sad face to enter a sad moment. You can then log into your repository at www.jkoolcloud.com to view your moments via the jKool User Interface. Click 'dashboard' in the upper right hand corner to login. Once logged in you can click the Tutorial button to see how to view your data in various different ways. This app is making use of the jkool-client-objc-streaming and jkool-client-objc-tracking api's. These api's can be found on GitHub as regular repositories and CocoaPods. Details can be found in the ReadMe's. This Moments app demonstrates the usage of these Api's. When logged into your repository, you will see your Moment's data as well as user experience data that the tracking Api is reporting. Please reach out to support@jkoolcloud.com if you experience any issues."; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
