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

#import "SetupViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults *appPrefs = [[NSUserDefaults alloc] init];
    if ([appPrefs objectForKey:@"token"])
    {
        setupLabel.text = @"Your jKool User Name";
        setupButton.hidden = TRUE;
        userName.text = [appPrefs objectForKey:@"userName"];
        firstName.text = [appPrefs objectForKey:@"firstName"];
        lastName.text = [appPrefs objectForKey:@"lastName"];
        email.text = [appPrefs objectForKey:@"email"];
        [userName setEnabled:false];
        [firstName setEnabled:false];
        [lastName setEnabled:false];
        [email setEnabled:false];
        [passwordLabel setHidden:true];
        [confirmPasswordLabel setHidden:true];
        [password setHidden:true];
        [confirmPassword setHidden:true];
    }
    else
    {
        setupLabel.text = @"Create a jKool User Name or enter an existing jKool User Name";
        setupButton.hidden = FALSE;
        [userName setEnabled:true];
        [firstName setEnabled:true];
        [lastName setEnabled:true];
        [email setEnabled:true];
        [passwordLabel setHidden:false];
        [confirmPasswordLabel setHidden:false];
        [password setHidden:false];
        [confirmPassword setHidden:false];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneAction:(id)sender {
    
    // user tapped the Done button, release first responder on the text view
    [userName resignFirstResponder];
}

- (IBAction)save:(id)sender {
    if (email.text.length == 0 || firstName.text.length == 0 || lastName.text.length == 0 || password.text.length == 0 || userName.text.length == 0)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Required Fields"
                                      message:@"All fields are required."
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
    else if (! [password.text isEqualToString:confirmPassword.text])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Passwords"
                                      message:@"Passwords don't match."
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
    else
    {
        setupLabel.text = @"Your jKool Account Information";
        setupButton.hidden = TRUE;
        NSUserDefaults *appPrefs = [[NSUserDefaults alloc] init];
        [userName setEnabled:false];
        [firstName setEnabled:false];
        [lastName setEnabled:false];
        [email setEnabled:false];
        [password setHidden:true];
        [confirmPassword setHidden:true];
        [passwordLabel setHidden:true];
        [confirmPasswordLabel setHidden:true];
        [appPrefs setObject:[userName text] forKey:@"userName"];
        [appPrefs setObject:[firstName text] forKey:@"firstName"];
        [appPrefs setObject:[lastName text] forKey:@"lastName"];
        [appPrefs setObject:[email text] forKey:@"email"];
        [self register];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSUserDefaults *appPrefs = [[NSUserDefaults alloc] init];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error == nil)
    {
        NSString *token = [object objectForKey:@"token"];
    [   appPrefs setObject:token forKey:@"token"];
    }


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



-(void)register{
    NSString *postString = @"http://test.jkoolcloud.com/jKoolAdmin?setup=yes&source=iphone&userName=";
    postString = [postString stringByAppendingString:userName.text];
    postString = [postString stringByAppendingString:@"&password="];
    postString = [postString stringByAppendingString:password.text];
    postString = [postString stringByAppendingString:@"&email="];
    postString = [postString stringByAppendingString:email.text];
    postString = [postString stringByAppendingString:@"&firstName="];
    postString = [postString stringByAppendingString:firstName.text];
    postString = [postString stringByAppendingString:@"&lastName="];
    postString = [postString stringByAppendingString:lastName.text];
    NSURL *url = [NSURL URLWithString:postString];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];
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
