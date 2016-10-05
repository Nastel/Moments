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

#import "jkEvent.h"
#import "jkTrackable.h"
#import "jkProperty.h"
#import "jkConstants.h"
#import "jKoolStreaming.h"

@implementation jkEvent


@synthesize msgCharset = _msgCharset;
@synthesize msgText = _msgText;
@synthesize msgTag = _msgTag;
@synthesize msgAgeUsec = _msgAgeUsec;
@synthesize msgEncoding = _msgEncoding;
@synthesize msgMimeType = _msgMimeType;
@synthesize msgSize = _msgSize;


// Msg Charset
- (NSString *)msgCharset {
    if (_msgText && !_msgCharset) {
        _msgCharset = DefaultCharSet;
    }
    
    return _msgCharset;
}

- (void)setMsgCharset:(NSString *)msgCharset {
    _msgCharset = msgCharset;
}
// Msg Encoding
- (NSString *)msgEncoding {
    if (_msgText && !_msgEncoding) {
        _msgEncoding = DefaultEncoding;
    }
    
    return _msgEncoding;
}

- (void)setMsgEncoding:(NSString *)msgEncoding {
    _msgEncoding = msgEncoding;
}
// Msg Mime Type
- (NSString *)msgMimeType {
    if (_msgText && !_msgMimeType) {
        _msgMimeType = DefaultMimeType;
    }
    
    return _msgMimeType;
}

- (void)setMsgMimeType:(NSString *)msgMimeType {
    _msgMimeType = msgMimeType;
}
// Msg Size
- (int) msgSize {
    if (_msgText) {
        _msgSize = _msgText.length;
    }
    
    return 0;
}

- (void)setMsgSize:(int)msgSize {
    _msgSize = msgSize;
}


// Msg Tag
- (NSString *)msgTag {
    if (!_msgTag) {
        _msgTag = [[UIDevice currentDevice] name];
    }
    
    return _msgTag;
}

- (void)setMsgTag:(NSString *)msgTag {
    _msgTag = msgTag;
}

- (id)init {
    self = [super init];
    [self setType: JK_TYPE_EVENT];    
    return self;
    
}

- (id)initWithName: (NSString*)name {
    self = [self init];
    [self setEventName:name];
    return self;
}

- (id)initWithName: (NSString*)name andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name andTrackingId:trackingId];
    [self setEventName:name];
    return self;
}

- (id)initWithName: (NSString*)name andTimeUsecAsLong:(long)timeUsec andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name andTrackingId:trackingId];
    [self setTimeUsec:timeUsec];
    return self;
}

- (id)initWithNameAndTimeUsec: (NSString*)name andTimeUsecAsDate:(NSDate*)timeUsec andTrackingId:(NSString*)trackingId  {
    self = [self initWithName:name andTrackingId:trackingId];
    [self setTimeUsecViaDate:timeUsec];
    return self;
}


- (NSMutableArray *) propertyList {
    NSMutableArray * properties = [super propertyList];
    if ([self msgEncoding] != nil)
    {
        [properties addObject: @"encoding"];
    }
    if ([self msgCharset] != nil)
    {
        [properties addObject: @"charset"];
    }
    if ([self msgText] != nil)
    {
        [properties addObject: @"msg-text"];
    }
    if ([self msgTag] != nil)
    {
        [properties addObject: @"msg-tag"];
    }
    if ([self msgSize] > 0)
    {
        [properties addObject: @"msg-size"];
    }
    if ([self msgMimeType]  != nil)
    {
        [properties addObject: @"mime-type"];
    }
    if ([self msgAgeUsec ] > 0)
    {
        [properties addObject:  @"msg-age"];
    }
    return properties;
}

- (NSMutableArray *) valueList {
    NSMutableArray * values = [super valueList];

    if ([self msgEncoding] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self msgEncoding]]];
    }
    if ([self msgCharset] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self msgCharset]]];
    }
    if ([self msgText] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self msgText]]];
    }
    if ([self msgTag] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self msgTag]]];
    }
    if ([self msgSize] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%i", [self msgSize]]];
    }
    if ([self msgMimeType] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self msgMimeType]]];
    }
    if ([self msgAgeUsec] > 0 && [self msgAgeUsec] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%ld", [self msgAgeUsec]]];
    }
    return values;
}

@end
