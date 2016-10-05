//
//  jKoolApplicationDelegate.m
//  Pods
//
//  Created by Catherine Bernardone on 9/20/16.
//
//

#import "jKoolTracking.h"
#import "jkActivity.h"
#import "jkProperty.h"
#import "jkLocation.h"
#import "jKoolStreaming.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/SystemConfiguration.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation jKoolTracking

UIBackgroundTaskIdentifier *backgroundUpdateTask;

+ (void) initializeTracking : (NSString *) token enableErrors : (bool) enableErrors enableActions : (bool) enableActions onlyIfWifi : (bool) onlyIfWifi
{
    jKoolData *sharedManager = [jKoolData sharedManager];
    [sharedManager setToken:token];
    [sharedManager setLocation:[[jkLocation alloc] init]];
    [[sharedManager location] kickOffLocationing];
    [self createjKoolActivity];
    [sharedManager setJkStreaming:[[jKoolStreaming alloc] init]];
    [[sharedManager jkStreaming] setToken:[sharedManager token]];
    [[sharedManager jkStreaming] initializeStream:nil];
    [sharedManager setConnectionType :[self connectionType]];
    [sharedManager setIpAddress: [self getIPAddress:YES]];
    [sharedManager setEnableErrors:enableErrors];
    [sharedManager setEnableActions:enableActions];
    [sharedManager setOnlyIfWifi:onlyIfWifi];
}

+ (void) setApplicationName : (NSString *) applName andDataCenter : (NSString *) dataCenter andResource : (NSString *) resource andSsn : (NSString *) ssn andCorrelators: (NSArray *) correlators andActivityName : (NSString *) activityName
{
    jKoolData *sharedManager = [jKoolData sharedManager];
    if (applName != nil)
    {
        [sharedManager setApplicationName:applName];
    }
    if (dataCenter != nil)
    {
        [sharedManager setDataCenter:dataCenter];
    }
    if (resource != nil)
    {
        [sharedManager setResource:resource];
    }
    if (ssn != nil)
    {
        [sharedManager setSsn:ssn];
    }
    else
    {
        [sharedManager setSsn:@"jKool-iOS-Agent"];
    }
    if ([correlators count] > 0)
    {
        [sharedManager setCorrelators:correlators];
    }
    if (activityName != nil)
    {
        [sharedManager setActivityName:activityName];
    }
    else
    {
        [sharedManager setActivityName:@"Tracking Activity"];
    }
}


+ (void)streamjKoolActivity
{
    [self beginBackgroundUpdateTask];
    jKoolData *sharedManager = [jKoolData sharedManager];
    [[sharedManager jkStreaming] setToken:[[jKoolData sharedManager]  token]];
    [[sharedManager jkStreaming] initializeStream:nil];
    jkActivity *activity = [[jKoolData sharedManager] activity];
    [activity setGeoAddr:[[sharedManager location] getCoordinates]];
    NSTimeInterval seconds = [[NSDate date]  timeIntervalSince1970];
    [activity setEndTimeUsec:seconds*1000.0];
    [activity setElapsedTimeUsec:[activity endTimeUsec] - [activity startTimeUsec]];
    [[sharedManager jkStreaming] stream:activity forUrl:@"activity"] ;
    [self endBackgroundUpdateTask];
}



+ (void)createjKoolActivity
{
    jKoolData *sharedManager = [jKoolData sharedManager];
    jkActivity *activity = [[jkActivity alloc] initWithName:@"Tracking Activity"];
    NSTimeInterval seconds = [[NSDate date]  timeIntervalSince1970];
    [activity setStartTimeUsec:seconds*1000.0];
    NSMutableArray * properties = [[NSMutableArray alloc] init];
    [activity setJkstatus:JK_END];
    //[activity setReasonCode:9];
    [activity setException:@"none"];
    [activity setResource:[sharedManager resource]];
    [activity setAppl:[sharedManager applicationName]];
    [activity setDataCenter:[sharedManager dataCenter]];
    if ([sharedManager activityName]!= nil)
    {
        [activity setEventName:[sharedManager activityName]];
    }
    [activity setSourceSsn:[sharedManager ssn]];
    [activity setCorrId:[sharedManager correlators]];
    [activity setNetAddr:[sharedManager ipAddress]];

    [activity setServer:[[UIDevice currentDevice] name]];
    [activity setNetAddr:[sharedManager ipAddress]];
    jkProperty * propiOSVersion = [[jkProperty alloc] initWithName:@"iOSVersion" andType:@"NSString" andValue:[[UIDevice currentDevice] systemVersion]];
    jkProperty * propModel = [[jkProperty alloc] initWithName:@"model" andType:@"NSString" andValue:[[UIDevice currentDevice] model]];
    jkProperty * propHardware = [[jkProperty alloc] initWithName:@"hardware" andType:@"NSString" andValue:[self platformRawString]];
    CTTelephonyNetworkInfo *phoneInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *phoneCarrier = [[phoneInfo subscriberCellularProvider] carrierName];
    jkProperty * propPhoneCarrier = [[jkProperty alloc] initWithName:@"phoneCarrier" andType:@"NSString" andValue: (phoneCarrier != nil) ? phoneCarrier : @"N/A"];
    jkProperty * propFreeMemory = [[jkProperty alloc] initWithName:@"freeMemory" andType:@"NSNumber" andValue:[NSString stringWithFormat:@"%ld",(long)get_free_memory]];
    [properties addObject:propiOSVersion];
    [properties addObject:propHardware];
    [properties addObject:propModel];
    [properties addObject:propPhoneCarrier];
    [properties addObject:propFreeMemory];
    [activity setProperties:properties];
    // Store activity so we can stream it later
    [[jKoolData sharedManager] setActivity:activity];
}

+ (NSString *)platformRawString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}
+ (NSString *)platformNiceString {
    NSString *platform = [self platformRawString];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (4G,2)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (4G,3)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}



+ (void) endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: backgroundUpdateTask];
    backgroundUpdateTask = UIBackgroundTaskInvalid;
}

+ (void) beginBackgroundUpdateTask
{
    backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

static natural_t get_free_memory(void)
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    vm_statistics_data_t vm_stat;
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
    {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}




+ (ConnectionType)connectionType

{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "8.8.8.8");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!success) {
        return ConnectionTypeUnknown;
    }
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL isNetworkReachable = (isReachable && !needsConnection);
    if (!isNetworkReachable) {
        return ConnectionTypeNone;
    } else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        return ConnectionType3G;
    } else {
        return ConnectionTypeWiFi;
    }
}


+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (bool) jKoolExceptionHandler: (NSException *) exception;
{
    jKoolData *sharedManager = [jKoolData sharedManager];
    if ([sharedManager enableErrors])
    {

        jkEvent *jKoolEvent = [[jkEvent alloc] initWithName:[NSString stringWithFormat:@"Uncaught Exception - %@",[exception name]]];
        [jKoolEvent setResource:[sharedManager vc]];
        [jKoolEvent setGeoAddr:[[sharedManager location] getCoordinates]];
        [jKoolEvent setParentTrackId:[[sharedManager activity] trackingId]];
        [jKoolEvent setAppl:[sharedManager applicationName]];
        [jKoolEvent setServer:@"none"];
        [jKoolEvent setDataCenter:[sharedManager dataCenter]];
        [jKoolEvent setException:exception.description];
        [jKoolEvent setJkSeverity:JK_SEV_FAILURE];
        [jKoolEvent setSourceSsn:@"jKool-iOS-Agent"];
        [[sharedManager jkStreaming] stream:jKoolEvent forUrl:@"event"];
        [self streamjKoolActivity];
    }
    return YES;
}

@end
