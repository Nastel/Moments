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

#import "jkProperty.h"

@implementation jkProperty

@synthesize name = _name;
@synthesize type = _type;
@synthesize value = _value;
@synthesize valueType = _valueType;

- (id)initWithName: (NSString*)name andType:(NSString*)type andValue:(NSString*)value{
    self = [super init];
    _name = name;
    _type = type;
    _value = value;
    return self;
}

- (NSString *)valueType {
    if ([self.value isKindOfClass:[NSString class]])
        return @"NSString";
    else if ([self.valueType isKindOfClass:[NSNumber class]])
        return @"NSNumber";
    else if ([self.valueType isKindOfClass:[NSDecimalNumber class]])
        return @"NSDecimalNumber";
    else if ([self.valueType isKindOfClass:[NSDate class]])
        return @"NSDate";
    else{
        return @"none";
    }
}

- (void)setValueType:(NSString *)valueType {
    _valueType = valueType;
}

- (bool ) isvalid {
    if (_name !=nil && _type != nil && _value != nil)
    {
        return YES;
    }
    else{
        return NO;
    }
    
}

- (NSMutableArray *) propertyList {
    NSMutableArray * properties = [[NSMutableArray alloc] init];
    [properties addObject: @"name"];
    [properties addObject: @"type"];
    [properties addObject: @"value"];
    [properties addObject: @"value-type"];
    return properties;
}

- (NSMutableArray *) valueList {
    NSMutableArray * values = [[NSMutableArray alloc] init];
    [values addObject: [NSString stringWithFormat:@"%@", [self name]]];
    [values addObject: [NSString stringWithFormat:@"%@", [self type]]];
    [values addObject: [NSString stringWithFormat:@"%@", [self value]]];
    [values addObject: [NSString stringWithFormat:@"%@", [self valueType]]];

    return values;
}





@end
