//
//  AppDelegate.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Set tabbar tint color programatically since storyboard has a bug and it won't be set
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    
    tabController.view.tintColor = [UIColor whiteColor];
    
    return YES;
}

@end
