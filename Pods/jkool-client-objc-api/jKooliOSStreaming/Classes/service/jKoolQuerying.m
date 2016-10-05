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

#import "jKoolQuerying.h"
#import "jkConstants.h"

@implementation jKoolQuerying
{
    NSURLSessionConfiguration *defaultConfigObject;
    NSURLSession *defaultSession;
    NSURL *url;
}

@synthesize token;

- (void)initializeQuery:(NSObject *) handler {
    defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    if (handler != nil)
    {
        [self setSendResponse:handler];
    }
    
}

- (void)query:(NSString *)query withMaxRows:(int) maxRows {
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *queryUrl = [NSString stringWithFormat:@"%@?jk_query=%@&jk_maxRows=%i&jk_token=%@", QueryingUrl, query, maxRows, token];
    url = [NSURL URLWithString:queryUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60000.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:token forHTTPHeaderField:@"token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];
}

- (void) stopQuerying
{
    defaultSession.invalidateAndCancel;
}


@end
