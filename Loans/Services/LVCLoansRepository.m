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

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LVCLoansRepository()

@property (strong, nonatomic) LVCNetworkProxy *networkProxy;
@property (strong, nonatomic) LVCDatabaseManager *databaseManager;

@end

@implementation LVCLoansRepository

#pragma mark - Public API

+ (instancetype)sharedRepository {
    static id _sharedRepository = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRepository = [[[self class] alloc] init];
    });
    return _sharedRepository;
}

- (RACSignal *)loans {
#warning Externalize path
    NSString *path = @"v1/loans/search.json";
    NSDictionary *params = @{@"status": @"fundraising"};
    
    @weakify(self)
    return [[[[[[self.networkProxy performRequestWithMethod:LVCNetworkProxyHTTPMethodGET onRESTPath:path withParams:params]
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
                  
                  @strongify(self)
                  return [self.databaseManager storeLoans:loansArray];
              }]
    deliverOn:[RACScheduler scheduler]]
    then:^RACSignal *{
        @strongify(self)
        return [self.databaseManager loans];
    }];
}

#pragma mark - Private methods

- (instancetype)init {
    if (self = [super init]) {
        self.networkProxy = [LVCNetworkProxy sharedProxy];
        self.databaseManager = [LVCDatabaseManager sharedManager];
    }
    return self;
}

#pragma mark -

@end
