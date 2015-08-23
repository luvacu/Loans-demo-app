//
//  LVCLoanTableViewCell.m
//  Loans
//
//  Created by Luis Valdés on 22/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCLoanTableViewCell.h"

#import "LVCLoan.h"

@interface LVCLoanTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation LVCLoanTableViewCell

+ (NSString *)preferredIdentifier {
    return NSStringFromClass(self.class);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = CGRectGetHeight(self.iconImageView.frame) / 2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.text = self.loan.name;
}

@end
