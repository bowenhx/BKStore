//
//  AppDelegate.m
//  BKStore
//
//  Created by calvin_tse on 2017/6/2.
//  Copyright © 2017年 calvin_tse. All rights reserved.
//

#import "AppDelegate.h"
#import "AppListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[AppListViewController alloc] init]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
