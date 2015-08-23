//
//  LVCAppDelegate.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

#import "LVCAppDelegate.h"

#import "LVCMasterViewController.h"
#import "LVCDetailViewController.h"

#import "LVCLoansRepository.h"

#import <AFNetworking/AFNetworking.h>


@interface LVCAppDelegate () <UISplitViewControllerDelegate>

@end

@implementation LVCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *detailNavigationController = [splitViewController.viewControllers lastObject];
    detailNavigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
    
    UINavigationController *masterNavigationController = [splitViewController.viewControllers firstObject];
    LVCMasterViewController *masterVC = (LVCMasterViewController *)masterNavigationController.topViewController;
    
    [self _loadComponents:masterVC];
    
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

#pragma mark - 

/**
 * Use this method to build the dependency object graph. It currently loads the default configuration
 * ('+ defaultRepository'), but you may create a different 'LVCLoansRepository' with other dependencies
 * ('- initWithNetworkProxy:(LVCNetworkProxy *)networkProxy databaseManager:(LVCDatabaseManager *)databaseManager')
 * such as a mock NetworkProxy or a Realm/XML/your-custom-DB-implementation DatabaseManager to change 
 * the behavior of the network and database layers. Also, you may want to inject your custom subclass 
 * of 'LVCLoansRepository' to implement a different behavior, such as always load the loans from the 
 * network and use the DB only when there is no Internet connection.
 */
- (void)_loadComponents:(LVCMasterViewController *)masterVC {
    LVCLoansRepository *repository = [LVCLoansRepository defaultRepository];
    // Inject dependency.
    masterVC.repository = repository;
}

@end
