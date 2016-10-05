//
//  AppDelegate.m
//  moments
//
//  Created by jKool LLC on 4/14/16.
//  Copyright © 2016 jKool LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "jKoolTracking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [jKoolTracking initializeTracking:@"your-token" enableErrors:YES enableActions:YES onlyIfWifi:YES];
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
