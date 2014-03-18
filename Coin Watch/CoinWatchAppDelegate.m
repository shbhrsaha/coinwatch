//
//  CoinWatchAppDelegate.m
//  Coin Watch
//
//  Created by Shubhro Saha on 1/30/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import "CoinWatchAppDelegate.h"
#import "CoinWatchViewController.h"

@implementation CoinWatchAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // will call performFetchWithCompletionHandler ever 5 seconds when app in background
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;
}

- (void)doFetch {
    NSString *direction = self.myViewController.theWatch.direction;
    BOOL triggered = self.myViewController.theWatch.triggered;
    float targetPrice = self.myViewController.theWatch.targetPrice;
    float actualPrice = [self.myViewController fetchPrice];
    
    if (targetPrice == 0.00) {
        return;
    }
    
    if (triggered) {
        return;
    }
    
    if ([direction isEqualToString:@"greater than"] && actualPrice > targetPrice) {
        [self makeNotification:[@"BTC is now greater than $" stringByAppendingString:[NSString stringWithFormat:@"%.2F", targetPrice]]];
        self.myViewController.theWatch.triggered = true;
    } else if ([direction isEqualToString:@"less than"] && actualPrice < targetPrice) {
        [self makeNotification:[@"BTC is now less than $" stringByAppendingString:[NSString stringWithFormat:@"%.2F", targetPrice]]];
        self.myViewController.theWatch.triggered = true;
    }
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [self doFetch];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)makeNotification:(NSString *)message {
    NSDate *alertTime = [[NSDate date]
                         dateByAddingTimeInterval:5];
    UIApplication* app = [UIApplication sharedApplication];
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
                                        init];
    if (notifyAlarm)
    {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.alertBody = message;
        [app scheduleLocalNotification:notifyAlarm];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self doFetch];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    float price = [self.myViewController fetchPrice];
    [self.myViewController.currentPrice performSelectorOnMainThread:@selector(setText : ) withObject:[NSString stringWithFormat:@"%.2F", price] waitUntilDone:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
