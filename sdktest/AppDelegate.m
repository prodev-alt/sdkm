//
//  AppDelegate.m
//  sdktest
//
//  Created by Mobile on 15.12.18.
//  Copyright © 2018 BMA. All rights reserved.
//

#import "AppDelegate.h"
#import <sdkm/Groopview.h>
#import "ChooseVideoController.h"
@import AirshipKit;
@import Firebase;

@interface AppDelegate () <UARegistrationDelegate, UAPushNotificationDelegate, UNUserNotificationCenterDelegate> {
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Push Notification
    [[UAirship push] resetBadge];
    
    [UAirship takeOff];
    [UAirship push].userPushNotificationsEnabled = YES;
    [UAirship push].defaultPresentationOptions = (UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
    [[UAirship push] setPushNotificationDelegate:self];
    
    // Add observer to the UAChannelCreatedEvent
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uaChannelCreated:)
                                                 name:UAChannelCreatedEvent object:nil];
    
    [[UAirship push] setRegistrationDelegate:self];
    
    NSTimeInterval duration = 180;
    [[UAirship shared].channelCapture enable:duration];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    // Groopview SDK initialization
    [[GVShared shared] setClientId:@"2"];
    [[GVShared shared] setClientSecret:@"ngy7TJDuanGDqystCDHoW735sTdHRG8jz71deF1b"];
    [[GVShared shared] setThemeColor:[UIColor colorWithRed:255.0 / 255.0 green:54.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseVideoController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChooseVideoController"];    
    [[GVShared shared] setChooseVideoController:vc];
    
    
    // Firebase
    [FIRApp configure];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [GVShared shared].lockOrientation;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UAAppIntegration application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [UAAppIntegration application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UAAppIntegration application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [UAAppIntegration userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [UAAppIntegration userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

#pragma mark - PushNotificationDelegate

- (void)receivedBackgroundNotification:(UANotificationContent *)notificationContent completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)receivedForegroundNotification:(UANotificationContent *)notificationContent completionHandler:(void (^)(void))completionHandler {
    
}

- (void)receivedNotificationResponse:(UANotificationResponse *)notificationResponse completionHandler:(void (^)(void))completionHandler {
    
}

#pragma mark - Notification Observer

- (void)uaChannelCreated:(id)sender {
    
}

#pragma mark - UARegistrationDelegate

- (void)registrationSucceededForChannelID:(NSString *)channelID deviceToken:(NSString *)deviceToken {
    NSLog(@"Channel ID: %@, Device Token: %@", channelID, deviceToken);
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:PREF_UA_TOKEN];
}

@end