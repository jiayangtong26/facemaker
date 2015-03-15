//
//  AppDelegate.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setSettingsPreferenceDefaults];
    [self setInitialLaunchPreferenceDefaults];
    [self customizeAppearance];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setSettingsPreferenceDefaults {
    NSLog(@"Initializing Setting Preference at launch");
    NSString *plistName = @"Root";
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSAssert(settingsBundle, @"Could not find Settings.bundle while loading defaults.");
    NSString *plistFullName = [NSString stringWithFormat:@"%@.plist", plistName];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:plistFullName]];
    NSAssert1(settings, @"Could not load plist '%@' while loading defaults.", plistFullName);
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSAssert1(preferences, @"Could not find preferences entry in plist '%@' while loading defaults.",
              plistFullName);
    NSMutableDictionary *defaultSetting = [NSMutableDictionary dictionary];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        id value = [prefSpecification objectForKey:@"DefaultValue"];
        if(key && value) {
            NSLog(@"NSUserDefaults: \"%@\" = \"%@\"", key, value);
            [defaultSetting setObject:value forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultSetting];
}

- (void)setInitialLaunchPreferenceDefaults {
    NSLog(@"Creating Initial Launch user preference");
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:[NSDate date]
                                                            forKey:@"Initial Launch"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    NSLog(@"NSUserDefaults: \"Initial Launch\" = %@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"Initial Launch"]);
}

#pragma mark - Appearance Proxy
- (void)customizeAppearance {
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor],
                                                          NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"Noteworthy-Bold" size:20.0],
                                                          NSFontAttributeName,
                                                          nil]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blueColor],
                                                          NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"Noteworthy-Bold" size:20.0],
                                                          NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}

@end
