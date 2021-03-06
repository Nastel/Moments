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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "jkEvent.h"
#import "jkActivity.h"
#import "jkSnapshot.h"
#import "jKoolService.h"

@interface jKoolStreaming : jKoolService

- (void)stream:(jkTrackable *)trackable  forUrl:(NSString*) path;
- (void)initializeStream:(NSObject *) handler;
- (void) stopStreaming;
@property NSString *token;

@end
