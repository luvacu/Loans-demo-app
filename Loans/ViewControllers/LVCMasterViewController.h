//
//  LVCMasterViewController.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

@import UIKit;

@class LVCLoansRepository;
@class LVCDetailViewController;

@interface LVCMasterViewController : UITableViewController

@property (strong, nonatomic) LVCLoansRepository *repository;
@property (strong, nonatomic) LVCDetailViewController *detailViewController;


@end

