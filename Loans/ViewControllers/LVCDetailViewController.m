//
//  LVCDetailViewController.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

#import "LVCDetailViewController.h"
#import "LVCLoansRepository.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface LVCDetailViewController ()

@end

@implementation LVCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self _configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[[LVCLoansRepository sharedRepository] loans] subscribeNext:^(NSArray *loans) {
        NSLog(@"Success, received loans: %lu", (unsigned long)loans.count);
    } error:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self _configureView];
    }
}

#pragma mark - Private methods

- (void)_configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

#pragma mark -


@end
