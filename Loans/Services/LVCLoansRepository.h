//
//  LVCLoansRepository.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

@class LVCNetworkProxy;
@class LVCDatabaseManager;

@class RACSignal;

@interface LVCLoansRepository : NSObject

/// @abstract Builds a LVCLoansRepository with the default configuration.
+ (instancetype)defaultRepository;

/// @abstract For customization or testing purposes. Use convenience initializer '+ defaultRepository' for default configuration.
- (instancetype)initWithNetworkProxy:(LVCNetworkProxy *)networkProxy databaseManager:(LVCDatabaseManager *)databaseManager;

/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans array from DB.
- (RACSignal *)loans;

@end
