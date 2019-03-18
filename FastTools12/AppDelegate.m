/*
 HI GUYS, THIS IS EXACTLY HOW FASTTOOL12 WORKS, IF YOU WANT TO HELP ME TO IMPROVE IT
 JUST CONTACT ME ON MY TWITTER: @ABOUTZEPH
 OFFICIAL REPO: HTTPS://MATTEOZAPPIA.GITHUB.IO/REPO
 OFFICIAL GITHUB REPO: HTTPS://GITHUB.COM/MATTEOZAPPIA/FASTTOOLS12
 */
//
//  AppDelegate.m
//  FastTools12
//
//  Created by Matteo Zappia on 17/02/2019.
//  Copyright © 2019 Matteo Zappia. All rights reserved.
//

#import "AppDelegate.h"
#import <NMSSH/NMSSH.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
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

-(void)LoadRootPassword{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastPassword = [defaults objectForKey:@"lastPassword"];
    rootPassword = lastPassword;
}



- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    UINavigationController *nav = (UINavigationController *) self.inputViewController.presentedViewController;
    
    
    NSLog(@"%@", shortcutItem.type);
    if ([shortcutItem.type isEqualToString:@"com.matteozappia.FastTools12.respring"]) {
        [self LoadRootPassword];
        NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                               withUsername:@"root"];
        
        
        
        if (session.isConnected) {
            [session authenticateByPassword: rootPassword];
            
            if (session.isAuthorized) {
                NSLog(@"Authentication succeeded");
            } else{
                NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
                @throw NSInternalInconsistencyException;
            }
        }
        
        NSError *error = nil;
        NSString *response = [session.channel execute:@"killall backboardd" error:&error];
        NSLog(@"%@", response);
        [session disconnect];
    }
    
        NSLog(@"%@", shortcutItem.type);
        if ([shortcutItem.type isEqualToString:@"com.matteozappia.FastTools12.reboot"]) {
        [self LoadRootPassword];
            NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                                   withUsername:@"root"];
            
            
            
            if (session.isConnected) {
                [session authenticateByPassword: rootPassword];
                
                if (session.isAuthorized) {
                    NSLog(@"Authentication succeeded");
                } else{
                    NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
                    @throw NSInternalInconsistencyException;
                }
            }
            
            NSError *error = nil;
            NSString *response = [session.channel execute:@"reboot" error:&error];
            NSLog(@"%@", response);
            [session disconnect];
            
            
        }
    
    NSLog(@"%@", shortcutItem.type);
    if ([shortcutItem.type isEqualToString:@"com.matteozappia.FastTools12.ldrestart"]) {
        [self LoadRootPassword];
        NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                               withUsername:@"root"];
        
        
        
        if (session.isConnected) {
            [session authenticateByPassword: rootPassword];
            
            if (session.isAuthorized) {
                NSLog(@"Authentication succeeded");
            } else{
                NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
                @throw NSInternalInconsistencyException;
            }
        }
        
        NSError *error = nil;
        NSString *response = [session.channel execute:@"ldrestart" error:&error];
        NSLog(@"%@", response);
        [session disconnect];
        
    }
    
    NSLog(@"%@", shortcutItem.type);
    if ([shortcutItem.type isEqualToString:@"com.matteozappia.FastTools12.safemode"]) {
        [self LoadRootPassword];
        NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                               withUsername:@"root"];
        
       
        
        if (session.isConnected) {
            [session authenticateByPassword: rootPassword];
            
            if (session.isAuthorized) {
                NSLog(@"Authentication succeeded");
            } else{
                NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
                @throw NSInternalInconsistencyException;
            }
        }
        
        NSError *error = nil;
        NSString *response = [session.channel execute:@"killall -SEGV SpringBoard" error:&error];
        NSLog(@"%@", response);
        [session disconnect];
        
        
    }
    
}

@end

