//
//  jKoolApplicationDelegate.h
//  Pods
//
//  Created by Catherine Bernardone on 9/20/16.
//
//

#import "jKoolData.h"

@interface jKoolTracking : NSObject


+ (void)streamjKoolActivity;
+ (void)createjKoolActivity;
+ (NSString *)platformNiceString;
+ (NSString *)platformRawString;
+ (void) beginBackgroundUpdateTask;
+ (void) endBackgroundUpdateTask;
+ (void) initializeTracking : (NSString *) token enableErrors : (bool) enableErrors enableActions : (bool) enableActions onlyIfWifi : (bool) onlyIfWifi;
+ (void) setApplicationName : (NSString *) applName andDataCenter : (NSString *) dataCenter andResource : (NSString *) resource andSsn : (NSString *) ssn andCorrelators: (NSArray *) correlators  andActivityName : (NSString *) activityName;
+ (ConnectionType)connectionType;
+ (bool) jKoolExceptionHandler: (NSException *) exception;
@end
