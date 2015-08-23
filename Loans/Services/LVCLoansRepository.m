//
//  LVCLoansRepository.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCLoansRepository.h"
#import "LVCNetworkProxy.h"
#import "LVCDatabaseManager.h"
#import "LVCConstantsManager.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LVCLoansRepository()

@property (strong, nonatomic) LVCNetworkProxy *networkProxy;
@property (strong, nonatomic) LVCDatabaseManager *databaseManager;

@end

@implementation LVCLoansRepository

#pragma mark - Public API

+ (instancetype)defaultRepository {
    LVCNetworkProxy *networkProxy = [LVCNetworkProxy defaultProxy];
    LVCDatabaseManager *databaseManager = [LVCDatabaseManager sharedManager];
    
    return [[self alloc] initWithNetworkProxy:networkProxy databaseManager:databaseManager];
}

- (instancetype)initWithNetworkProxy:(LVCNetworkProxy *)networkProxy databaseManager:(LVCDatabaseManager *)databaseManager {
    if (self = [super init]) {
        self.networkProxy = networkProxy;
        self.databaseManager = databaseManager;
    }
    return self;
}

/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans array from DB.
- (RACSignal *)loans {
    @weakify(self)
    return [[self _fetchAllLoans]
             flattenMap:^RACStream *(NSArray *loans) {
                 if (!loans || loans.count == 0) {
                     NSLog(@"No loans in DB. Download from server.");
                     @strongify(self)
                     return [self _populateLoansDatabaseAndFetch];
                 }
                 return [RACSignal return:loans];
             }];
}

#pragma mark - Private methods

/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans array from DB.
- (RACSignal *)_populateLoansDatabaseAndFetch {
    @weakify(self)
    return [[[[self _downloadLoans] // Download and import will be performed on a background thread
              flattenMap:^RACStream *(NSArray *rawLoans) {
                  @strongify(self)
                  return [self _importLoans:rawLoans];
              }]
              deliverOn:[RACScheduler mainThreadScheduler]] // Fetch will be performed on the main thread
              then:^RACSignal *{
                  @strongify(self)
                  return [self _fetchAllLoans];
              }];
}

/// @return RACSignal Next: (NSArray<NSDictionary *> *)loansArray.
- (RACSignal *)_downloadLoans {
    NSString *path = [LVCConstantsManager APIPathLoansSearch];
    NSDictionary *params = @{@"status": @"fundraising"};
    
    return [[[[self.networkProxy performRequestWithMethod:LVCNetworkProxyHTTPMethodGET onRESTPath:path withParams:params]
              subscribeOn:[RACScheduler scheduler]]
              deliverOn:[RACScheduler scheduler]]
              flattenMap:^RACStream *(NSDictionary *JSON) {
                  id loans = JSON[@"loans"];
                  
                  NSArray *loansArray = nil;
                  if ([loans isKindOfClass:NSArray.class]) {
                      loansArray = loans; // Array with multiple objects
                  } else if ([loans isKindOfClass:NSDictionary.class]) {
                      loansArray = @[loans]; // Array with a single object
                  }
                  return [RACSignal return:loansArray];
              }];
}

/// @return RACSignal Completed or Error
- (RACSignal *)_importLoans:(NSArray *)loans {
    return [self.databaseManager importLoans:loans];
}

/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans array from DB.
- (RACSignal *)_fetchAllLoans {
    return [self.databaseManager loans];
}

#pragma mark -

@end
