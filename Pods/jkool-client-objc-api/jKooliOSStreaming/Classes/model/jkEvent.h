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
#import "jkTrackable.h"


@interface jkEvent : jkTrackable 

@property (retain, nonatomic) NSString * msgText;
@property (retain, nonatomic) NSString * msgTag;
@property (retain, nonatomic) NSString *  msgCharset;
@property (retain, nonatomic) NSString *  msgEncoding;
@property (retain, nonatomic) NSString *  msgMimeType;
@property (nonatomic) long msgAgeUsec;
@property (nonatomic) int msgSize;

- (NSMutableArray *) propertyList;
- (NSMutableArray *) valueList;
- (id)initWithName: (NSString*)name;
- (id)initWithName: (NSString*)name andTrackingId:(NSString*)trackingId;
- (id)initWithName: (NSString*)name andTimeUsecAsLong:(long)timeUsec andTrackingId:(NSString*)trackingId;
- (id)initWithNameAndTimeUsec: (NSString*)name andTimeUsecAsDate:(NSDate*)timeUsec andTrackingId:(NSString*)trackingId;

@end
