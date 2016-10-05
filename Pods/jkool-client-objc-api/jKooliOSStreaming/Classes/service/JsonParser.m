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

#import "JsonParser.h"

@implementation JsonParser {
    NSString *_currentJson;
}

-(instancetype) init {
    self = [super init];
    if (self) {
        _receivedJsons = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSDictionary *)lastReceivedJson {
    return [_receivedJsons lastObject];
}

-(void) acceptString:(NSString *)string {
    if (!_currentJson) {
        _currentJson = @"";
    }
    
    _currentJson = [_currentJson stringByAppendingString:string];
    
    if ([string isEqual: @"}"]) {
        [_receivedJsons addObject:[self jsonDataForString:_currentJson]];
        _currentJson = nil;
    }
}

-(NSDictionary *) jsonDataForString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        return nil;
    } else {
        return dictionary;
    }
}

@end
