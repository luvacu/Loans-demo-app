//
//  LVCMasterViewController.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

#import "LVCMasterViewController.h"
#import "LVCDetailViewController.h"
#import "LVCLoanTableViewCell.h"

#import "LVCLoansRepository.h"
#import "LVCLoan.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface LVCMasterViewController ()

@property (strong, nonatomic) NSMutableArray *loans;

@end

@implementation LVCMasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
//        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    
    [self _fetchLoans];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailViewController = (LVCDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LVCLoan *selectedLoan = self.loans[indexPath.row];
        LVCDetailViewController *controller = (LVCDetailViewController *)[[segue destinationViewController] topViewController];
        controller.loan = selectedLoan;
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVCLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LVCLoanTableViewCell.preferredIdentifier forIndexPath:indexPath];
    cell.loan = self.loans[indexPath.row];
    return cell;
}

//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    LVCLoan *selectedLoan = self.loans[indexPath.row];
//    LVCDetailViewController *controller = (LVCDetailViewController *)[[segue destinationViewController] topViewController];
//    controller.loan = selectedLoan;
//    
//    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//    controller.navigationItem.leftItemsSupplementBackButton = YES;
//}

#pragma mark - Private methods

- (void)_fetchLoans {
    @weakify(self)
    [[[LVCLoansRepository sharedRepository] loans]
     subscribeNext:^(NSArray *loans) {
         NSLog(@"Loans read from repository: %lu", (unsigned long)loans.count);
         @strongify(self)
         [self _addLoans:loans];
     } error:^(NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}

- (void)_addLoans:(NSArray *)newLoans {
    if (!self.loans) {
        self.loans = [[NSMutableArray alloc] initWithCapacity:newLoans.count];
    }
    NSUInteger startRow = self.loans.count;
    [self.loans addObjectsFromArray:newLoans];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:newLoans.count];
    for (__unused id loan in newLoans) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startRow++ inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -

@end
