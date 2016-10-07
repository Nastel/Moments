/*
 * Copyright (c) 2016 jKool, LLC. All Rights Reserved.
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

#import "AppDelegate.h"
#import "jKoolTracking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *appPrefs = [[NSUserDefaults alloc] init];
    [jKoolTracking initializeTracking:[appPrefs objectForKey:@"token"] enableErrors:YES enableActions:YES onlyIfWifi:YES];
    [jKoolTracking setApplicationName:@"Cathys Application" andDataCenter:@"Cathys Data Center" andResource:@"Activity Resource" andSsn:nil andCorrelators:[NSArray arrayWithObjects:@"123",@"456",@"789", nil] andActivityName:@"Cathys Activity Name"];
    NSSetUncaughtExceptionHandler(&onUncaughtException);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
        [jKoolTracking streamjKoolActivity];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
        [jKoolTracking createjKoolActivity];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
        [jKoolTracking createjKoolActivity];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

void onUncaughtException(NSException *exception)
{
    [jKoolTracking jKoolExceptionHandler:exception];
    // Sleeping is necessary to give it time to streaam.
    [NSThread sleepForTimeInterval:5.0f];
}

@end
