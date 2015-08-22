//
//  LVCDetailViewController.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

@import UIKit;

@class LVCLoan;


@interface LVCDetailViewController : UIViewController

@property (strong, nonatomic) LVCLoan *loan;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

