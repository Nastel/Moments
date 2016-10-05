/*
 * Copyright (c) 2010 jKool, LLC. All Rights Reserved.
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

#import "jKoolStreaming.h"
#import "jkConstants.h"

@implementation jKoolStreaming
{
    NSURLSessionConfiguration *defaultConfigObject;
    NSURLSession *defaultSession;
    NSURL *url;
}

@synthesize token;

- (void)initializeStream:(NSObject *) handler {
    defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    if (handler != nil)
    {
        [self setSendResponse:handler];
    }

   }


- (void)stream:(jkTrackable *)trackable  forUrl:(NSString*) path{
   url = [NSURL URLWithString:[StreamingUrl stringByAppendingString:path]];
   NSDictionary *jKoolDict = [self createJson:trackable];
   NSData *requestData = [NSJSONSerialization  dataWithJSONObject:jKoolDict options:NSJSONWritingPrettyPrinted error:0];
    NSString *strData = [[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",strData);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:token forHTTPHeaderField:@"token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];
}

- (void) stopStreaming
{
    defaultSession.invalidateAndCancel;
}


- (NSDictionary *)createJson:(jkTrackable *)trackable  {
    NSMutableArray * properties = [trackable propertyList];
    NSMutableArray * values = [trackable valueList];
    return [NSDictionary dictionaryWithObjects:values forKeys:properties];
}

@end
