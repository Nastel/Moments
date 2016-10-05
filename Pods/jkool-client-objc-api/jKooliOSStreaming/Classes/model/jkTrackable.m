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

#import "jkTrackable.h"
#import "jkConstants.h"
#import "jkProperty.h"
#import "jkSnapshot.h"
#include <pthread.h>

@implementation jkTrackable
{
    CLLocation* detectedLocation;
}

@synthesize compCode = _compCode;
@synthesize jkSeverity = _jkSeverity;
@synthesize type = _type;

@synthesize timeUsec = _timeUsec;
@synthesize startTimeUsec = _startTimeUsec;
@synthesize endTimeUsec = _endTimeUsec;
@synthesize elapsedTimeUsec = _elapsedTimeUsec;
@synthesize waitTimeUsec = _waitTimeUsec;
@synthesize pid = _pid;
@synthesize tid = _tid;

@synthesize reasonCode = _reasonCode;

@synthesize trackingId = _trackingId;
@synthesize sourceUrl = _sourceUrl;
@synthesize exception = _exception;
@synthesize parentTrackId = _parentTrackId;

@synthesize appl = _appl;
@synthesize dataCenter = _dataCenter;
@synthesize geoAddr = _geoAddr;
@synthesize eventName = _eventName;
@synthesize deviceName = _deviceName;


@synthesize location = _location;
@synthesize resource = _resource;
@synthesize server = _server;
@synthesize netAddr = _netAddr;
@synthesize sourceFqn = _sourceFqn;
@synthesize sourceSsn = _sourceSsn;
@synthesize user = _user;

@synthesize corrId = _corrId;
@synthesize properties = _properties;
@synthesize snapshots = _snapshots;

// Data Center
- (NSString *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = DefaultDCName;
    }
    
    return _dataCenter;
}

- (void)setDataCenter:(NSString *)dataCenter {
    _dataCenter = dataCenter;
}

// Server
- (NSString *)server {
    if (!_server) {
        _server = DefaultServer;
    }
    
    return _server;
}

- (void)setServer:(NSString *)server {
    _server = server;
}

// Server
- (NSString *)deviceName {
    if (!_deviceName) {
        _deviceName = [[UIDevice currentDevice] name];
    }
    
    return _deviceName;
}

- (void)setDeviceName:(NSString *)deviceName {
    _deviceName = deviceName;
}

// Tid
- (long)tid {
    if (!_tid) {
        mach_port_t machTID = pthread_mach_thread_np(pthread_self());
        _tid = machTID;
    }
    
    return _tid;
}

- (void)setTid:(long)tid {
    _tid = tid;
}

// Network Address
- (NSString *)netAddr {
    if (!_netAddr) {
        _netAddr = DefaultNWAddr;
    }
    
    return _netAddr;
}

- (void)setNetAddr:(NSString *)netAddr {
    _netAddr = netAddr;
}

// Application
- (NSString *)appl {
    if (!_appl) {
        _appl = DefaultAppName;
    }
    
    return _appl;
}

- (void)setAppl:(NSString *)appl {
    _appl = appl;
}


// Geo
- (NSString *)geoAddr {
    if (!_geoAddr) {
        _geoAddr = DefaultGeoAddr;
    }
    
    return _geoAddr;
}

- (void)setGeoAddr:(NSString *)geoAddr {
    _geoAddr = geoAddr;
}

// Comp Code
- (enum CompCodes)compCode {
    if (!_compCode) {
        _compCode = JK_CC_SUCCESS;
    }
    
    return _compCode;
}

- (void)setCompCode:(enum CompCodes)compCode {
    _compCode = compCode;
}

// Severity
- (enum Severities)jkSeverity {
    if (!_jkSeverity) {
        _jkSeverity = JK_SEV_INFO;
    }
    
    return _jkSeverity;
}

- (void)setSeverity:(enum Severities)jkSeverity {
    _jkSeverity = jkSeverity;
}

// Type
- (enum EventTypes)type {
    if (!_type) {
        _type = JK_TYPE_EVENT;
    }
    
    return _type;
}

- (void)setType:(enum EventTypes)type {
    _type = type;
}

// Source FQN
- (NSString *)sourceFqn {
    if (!_sourceFqn) {
        _sourceFqn = [NSString stringWithFormat:@"APPL=%@#SERVER=%@#NETADDR=%@#DATACENTER=%@#GEOADDR=%@#DEVICE=%@", [self appl], [self server], [self netAddr], [self dataCenter], [self geoAddr], [self deviceName]];

    }
    
    return _sourceFqn;
}

- (void)setSourceFqn:(NSString *)sourceFqn{
    _sourceFqn = sourceFqn;
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

// Start Time
- (long long)startTimeUsec {
    if (_startTimeUsec > 0)
        return _startTimeUsec;
    else
        return [self timeUsec];
}

- (void)setStartTimeUsec:(long long)startTimeUsec {
    _startTimeUsec = startTimeUsec * 1000;
}

- (void)setStartTimeUsecViaDate:(NSDate *)startTimeUsec {
    NSTimeInterval seconds = [startTimeUsec timeIntervalSince1970];
    _startTimeUsec = seconds*1000000.0;
}

// End Time
- (long long)endTimeUsec {
    if (_endTimeUsec > 0)
        return _endTimeUsec;
    else
        return [self startTimeUsec] + [self elapsedTimeUsec];
}

- (void)setEndTimeUsec:(long long)endTimeUsec {
    _endTimeUsec = endTimeUsec * 1000;
}

- (void)setEndTimeUsecViaDate:(NSDate *)endTimeUsec {
    NSTimeInterval seconds = [endTimeUsec timeIntervalSince1970];
    _endTimeUsec = seconds*1000000.0;
}

// Elapsed Time
- (long)elapsedTimeUsec {
    if (_elapsedTimeUsec > 0)
        return _elapsedTimeUsec;
    else
        return 0;
}

- (void)setElapsedTimeUsec:(long)elapsedTime {
    _elapsedTimeUsec = elapsedTime;
}


- (id)init {
    self = [super init];
    NSUUID *theUUID = [NSUUID UUID];
    _trackingId = [theUUID UUIDString];
    return self;
}

- (bool) isValid
{
    if (_eventName != nil && _appl != nil && _netAddr != nil && _server != nil & _dataCenter != nil && _geoAddr != nil && _startTimeUsec >=0 && _endTimeUsec >=0 && _elapsedTimeUsec >=0)
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
    [properties addObject: @"tracking-id"];
    if ([self eventName] != nil)
    {
        [properties addObject: @"operation"];
    }
    [properties addObject: @"source-fqn"];
    [properties addObject: @"comp-code"];
    [properties addObject: @"severity"];
    [properties addObject: @"type"];
    [properties addObject: @"time-usec"];
    [properties addObject: @"start-time-usec"];
    [properties addObject: @"end-time-usec"];
    [properties addObject: @"elapsed-time-usec"];
    if ([self sourceUrl] != nil)
    {
        [properties addObject: @"source-url"];
    }
    if ([self reasonCode] > 0)
    {
        [properties addObject: @"reason-code"];
    }
    if ([self waitTimeUsec] > 0)
    {
        [properties addObject: @"wait-time-usec"];
    }
    if ([self parentTrackId]  != nil)
    {
        [properties addObject: @"parent-id"];
    }
    if ([self properties] != nil)
    {
        [properties addObject:@"properties"];
    }
    if ([self tid] > 0)
    {
        [properties addObject:@"tid"];
    }
    if ([self pid] > 0)
    {
        [properties addObject:@"pid"];
    }
    if ([self exception] != nil)
    {
        [properties addObject:@"exception"];
    }
    if ([self user] != nil)
    {
        [properties addObject:@"user"];
    }
    if ([self resource] != nil)
    {
        [properties addObject:@"resource"];
    }
    if ([self snapshots] != nil)
    {
        [properties addObject:@"snapshots"];
    }
    if ([self corrId] != nil)
    {
        [properties addObject:@"corrid"];
    }
    if ([self sourceSsn] != nil)
    {
        [properties addObject:@"source-ssn"];
    }
    return properties;
}

- (NSMutableArray *) valueList {
    NSMutableArray * values = [[NSMutableArray alloc] init];
    
    [values addObject: [NSString stringWithFormat:@"%@", [self trackingId]]];
    if ([self eventName] != nil)
    {
        [values addObject:[self eventName]];
    }
    [values addObject: [NSString stringWithFormat:@"%@", [self sourceFqn]]];
    [values addObject: [NSString stringWithFormat:@"%@", [jkConstants formatCompCodeToString :[self compCode]]]];
    [values addObject: [NSString stringWithFormat:@"%@", [jkConstants formatSeveritiesToString :[self jkSeverity]]]];
    [values addObject: [NSString stringWithFormat:@"%@", [jkConstants formatEventTypeToString :[self type]]]];
    [values addObject: [[NSNumber alloc] initWithLongLong:[self timeUsec]]];
    [values addObject: [[NSNumber alloc] initWithLongLong:[self startTimeUsec]]];
    [values addObject: [[NSNumber alloc] initWithLongLong:[self endTimeUsec]]];
    [values addObject: [NSString stringWithFormat:@"%ld", [self elapsedTimeUsec]]];
    if ([self sourceUrl] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self sourceUrl]]];
    }
    if ([self reasonCode] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%i", [self reasonCode]]];
    }
    if ([self waitTimeUsec] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%ld", [self waitTimeUsec]]];
    }
    if ([self parentTrackId] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self parentTrackId]]];
    }
    if ([self properties] != nil)
    {
        NSMutableArray * propertyArray = [[NSMutableArray alloc] init];
        for (jkProperty *prop in [self properties])
        {
            [propertyArray addObject: [NSDictionary dictionaryWithObjects:[prop valueList] forKeys:[prop propertyList]]];
        }
        [values addObject:propertyArray];
    }
    if ([self tid] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%ld", [self tid]]];    }
    if ([self pid] > 0)
    {
        [values addObject: [NSString stringWithFormat:@"%ld", [self pid]]];
    }
    if ([self exception] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self exception]]];
    }
    if ([self user] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self user]]];
    }
    if ([self resource] != nil)
    {
        [values addObject: [NSString stringWithFormat:@"%@", [self resource]]];
    }
    if ([self snapshots] != nil)
    {
        NSMutableArray * snapshotArray = [[NSMutableArray alloc] init];
        for (jkSnapshot *snapshot in [self snapshots])
        {
            [snapshotArray addObject: [NSDictionary dictionaryWithObjects:[snapshot valueList] forKeys:[snapshot propertyList]]];
        }
        [values addObject:snapshotArray];
    }
    if ([self corrId] != nil)
    {
        [values addObject: [self corrId]];
    }
    if ([self sourceSsn] != nil)
    {
        [values addObject: [self sourceSsn]];
    }


    return values;
}



@end
