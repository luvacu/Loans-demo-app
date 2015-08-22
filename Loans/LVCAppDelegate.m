//
//  LVCAppDelegate.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

#import "LVCAppDelegate.h"
#import "LVCDetailViewController.h"

@interface LVCAppDelegate () <UISplitViewControllerDelegate>

@end

@implementation LVCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    return YES;
}


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:UINavigationController.class]
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:LVCDetailViewController.class]
        && ([(LVCDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] loan] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
