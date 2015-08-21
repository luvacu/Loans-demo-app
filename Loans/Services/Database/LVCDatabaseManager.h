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

/// @abstract Performs import on the current calling thread.
- (RACSignal *)storeLoans:(NSArray *)array;

/// @abstract Performs a fetch on the current calling thread.
- (RACSignal *)loans;

@end
