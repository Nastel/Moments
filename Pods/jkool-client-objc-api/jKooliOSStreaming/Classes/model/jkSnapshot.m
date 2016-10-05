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

#import "jkSnapshot.h"
#import "jkConstants.h"
#import "jkProperty.h"

@implementation jkSnapshot

@synthesize category = _category;
@synthesize name = _name;
@synthesize timeUsec = _timeUsec;
@synthesize properties = _properties;
@synthesize type = _type;

// Type
- (enum EventTypes)type {
    if (!_type) {
        _type = JK_TYPE_SNAPSHOT;
    }
    
    return _type;
}

- (void)setType:(enum EventTypes)type {
    _type = type;
}

// Time
- (long long)timeUsec {
    if (_timeUsec > 0)
    {
        return _timeUsec;
    }
    else
    {
        NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
        return seconds*1000000.0;
    }
}

- (void)setTimeUsec:(long long)timeUsec {
    _timeUsec = timeUsec * 1000;
}

- (void)setTimeUsecViaDate:(NSDate *)timeUsec {
    NSTimeInterval seconds = [timeUsec timeIntervalSince1970];
    _timeUsec = seconds*1000000.0;
}

- (bool) isValid
{
    if (_category != nil && _name != nil && _timeUsec >= 0 && _properties != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSMutableArray *) propertyList {
    NSMutableArray * properties = [[NSMutableArray alloc] init];
    [properties addObject: @"category"];
    [properties addObject: @"name"];
    [properties addObject: @"time-usec"];
    [properties addObject: @"properties"];
    [properties addObject:@"type"];
    return properties;
}

- (NSMutableArray *) valueList {
    NSMutableArray * values = [[NSMutableArray alloc] init];
    [values addObject: [NSString stringWithFormat:@"%@", [self category]]];
    [values addObject: [NSString stringWithFormat:@"%@", [self name]]];
    [values addObject: [[NSNumber alloc] initWithLongLong: [self timeUsec]]];
    if (_properties != nil)
    {
        NSMutableArray * propertyArray = [[NSMutableArray alloc] init];
        for (jkProperty *prop in [self properties])
        {
            [propertyArray addObject: [NSDictionary dictionaryWithObjects:[prop valueList] forKeys:[prop propertyList]]];
        }
        [values addObject:propertyArray];
    }
    [values addObject: [NSString stringWithFormat:@"%@", [jkConstants formatEventTypeToString :[self type]]]];
    
    return values;
}



@end
