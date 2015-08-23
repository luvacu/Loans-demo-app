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
#import <SVProgressHUD/SVProgressHUD.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface LVCMasterViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) NSMutableArray *loans;

@end

@implementation LVCMasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self _isFirstRun]) {
        [self _showEmptyView];
    } else {
        [self _fetchLoans];
    }
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

#pragma mark - Private methods

- (void)_fetchLoans {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1]];
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:49/255.f green:170/255.f blue:57/255.f alpha:1]];
    [SVProgressHUD show];
    
    @weakify(self)
    [[[LVCLoansRepository sharedRepository] loans]
     subscribeNext:^(NSArray *loans) {
         NSLog(@"Loans read from repository: %lu", (unsigned long)loans.count);
         [SVProgressHUD showSuccessWithStatus:nil];
         
         @strongify(self)
         [self _hideEmptyView];
         [self _addLoans:loans];
     } error:^(NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD showErrorWithStatus:@"An error occurred, please try again later"];
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

- (BOOL)_isFirstRun {
    BOOL firstRun = NO;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstRun"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        firstRun = YES;
    }
    return firstRun;
}

- (void)_showEmptyView {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    // Remove cell separators
    self.tableView.tableFooterView = [UIView new];
}

- (void)_hideEmptyView {
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetSource = nil;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"cash"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"No loans yet";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:182/255.f green:182/255.f blue:182/255.f alpha:1]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Tap to load them from server";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:190/255.f green:190/255.f blue:190/255.f alpha:1]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self _fetchLoans];
}

#pragma mark -

@end
