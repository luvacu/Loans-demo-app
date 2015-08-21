//
//  LVCLoansRepository.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

@class RACSignal;

@interface LVCLoansRepository : NSObject

+ (instancetype)sharedRepository;

- (RACSignal *)loans;

@end
