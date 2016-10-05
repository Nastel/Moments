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

#import "jkActivity.h"
#import "jkTrackable.h"
#import "jKoolStreaming.h"

@implementation jkActivity

@synthesize jkstatus = _jkstatus;

- (enum Statuses)jkstatus {
    if (!_jkstatus && [self exception] != nil) {
        _jkstatus = JK_END;
    }
    else
    {
        _jkstatus = JK_EXCEPTION;
    }
    return _jkstatus;
}

- (void)setJkstatus:(enum Statuses)jkstatus {
    _jkstatus = jkstatus;
}

- (id)init {
    self = [super init];
    [self setType: JK_TYPE_ACTIVITY];
    return self;
}

- (id)initWithName: (NSString*)name  {
    self = [self init];
    [self setEventName:name];
    return self;
}

- (id)initWithName: (NSString*)name andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name];
    [self setTrackingId:trackingId];
    return self;
}

- (id)initWithName: (NSString*)name andTimeUsecAsLong:(long)timeUsec andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name andTrackingId: trackingId];
    [self setTimeUsec:timeUsec];
    return self;
}

- (id)initWithNameAndTimeUsec: (NSString*)name andTimeUsecAsDate:(NSDate*)timeUsec andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name andTrackingId: trackingId];
    [self setTimeUsecViaDate:timeUsec];
    return self;
}
- (NSMutableArray *) propertyList {
    NSMutableArray * properties = [super propertyList];
    [properties addObject: @"status"];
    return properties;
}

- (NSMutableArray *) valueList {
    NSMutableArray * values = [super valueList];
   [values addObject: [NSString stringWithFormat:@"%@", [jkConstants formatStatusString:[self jkstatus]]]];
     return values;
}

@end
