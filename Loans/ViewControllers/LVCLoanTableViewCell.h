//
//  LVCLoanTableViewCell.h
//  Loans
//
//  Created by Luis Valdés on 22/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import UIKit;

@class LVCLoan;

@interface LVCLoanTableViewCell : UITableViewCell

@property (strong, nonatomic) LVCLoan *loan;

+ (NSString *)preferredIdentifier;

@end
