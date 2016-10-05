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
#import "jkConstants.h"
#import <CoreLocation/CoreLocation.h>

@interface jkTrackable : NSObject <CLLocationManagerDelegate>

@property (nonatomic) enum CompCodes compCode;
@property (nonatomic) enum Severities jkSeverity;
@property (nonatomic) enum EventTypes type;

@property (nonatomic) long long timeUsec;
@property (nonatomic) long long startTimeUsec;
@property (nonatomic) long long endTimeUsec;
@property (nonatomic) long elapsedTimeUsec;
@property (nonatomic) long waitTimeUsec;
@property (nonatomic) long pid;
@property (nonatomic) long tid;

@property (nonatomic) int reasonCode;

@property (retain, nonatomic) NSString * trackingId;
@property (retain, nonatomic) NSString * sourceUrl;
@property (retain, nonatomic) NSString * exception;
@property (retain, nonatomic) NSString * parentTrackId;


@property (retain, nonatomic) NSString * dataCenter;
@property (retain, nonatomic) NSString * geoAddr;
@property (retain, nonatomic) NSString * eventName;
@property (retain, nonatomic) NSString * appl;
@property (retain, nonatomic) NSString * deviceName;

@property (retain, nonatomic) NSString * location;
@property (retain, nonatomic) NSString * resource;
@property (retain, nonatomic) NSString * server;
@property (retain, nonatomic) NSString * netAddr;
@property (retain, nonatomic) NSString * user;
@property (retain, nonatomic) NSString *sourceFqn;
@property (retain, nonatomic) NSString *sourceSsn;

@property (retain, nonatomic) NSArray* corrId;
@property (retain, nonatomic) NSMutableArray * properties;
@property (retain, nonatomic) NSMutableArray * snapshots;

- (void)setTimeUsecViaDate:(NSDate *)timeUsec;
- (NSMutableArray *) valueList;
- (NSMutableArray *) propertyList;

@end
