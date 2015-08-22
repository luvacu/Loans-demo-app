//
//  LVCDatabaseManager.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

@class RACSignal;


@interface LVCDatabaseManager : NSObject

+ (instancetype)sharedManager;

/// @abstract Creates and stores new Loans from array of NSDictionary.
/// @warning Performs import on a background thread.
/// @return RACSignal Completed or Error
- (RACSignal *)importLoans:(NSArray *)array;

/// @abstract Retrieves all loans stored in DB.
/// @warning Performs a fetch on the current calling thread.
/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans.
- (RACSignal *)loans;

@end
