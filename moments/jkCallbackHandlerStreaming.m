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

#import "jkCallbackHandlerStreaming.h"

@interface jkCallbackHandlerStreaming ()

@end

@implementation jkCallbackHandlerStreaming


- (void) handlejKoolResponse:(NSData *) data  {
    

    NSString *alertText = @"Yourrrrr happy moment has been saved. Please log into www.jkoolcloud.com to see all of your moments.";
   
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
    
    
    alert.popoverPresentationController.sourceView = [self vc].view;
    alert.popoverPresentationController.sourceRect = CGRectMake([self vc].view.bounds.size.width / 2.0, [self vc].view.bounds.size.height / 2.0, 1.0, 1.0);
    
    [[self vc] presentViewController:alert animated:YES completion:nil];
    
    

}

@end
