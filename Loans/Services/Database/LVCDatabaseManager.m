//
//  LVCDatabaseManager.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCDatabaseManager.h"
#import "LVCLoan.h"

#import <MagicalRecord/MagicalRecord.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation LVCDatabaseManager

#pragma mark - Public API

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
    });
    return _sharedManager;
}

/// @return RACSignal Completed or Error
- (RACSignal *)importLoans:(NSArray *)array {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSArray *importedLoans = [LVCLoan MR_importFromArray:array inContext:localContext];
            NSLog(@"Imported %lu loans in DB.", importedLoans.count);
        } completion:^(BOOL contextDidSave, NSError *error) {
            if (error) {
                [subscriber sendError:error];
                return ;
            }
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

/// @return RACSignal Next: (NSArray<LVCLoan *> *)loans.
- (RACSignal *)loans {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSArray *loans = [LVCLoan MR_findAll];
        NSLog(@"Found %lu loans in DB.", loans.count);
        [subscriber sendNext:loans];
        [subscriber sendCompleted];
        return nil;
    }];
}

#pragma mark - Private methods

- (instancetype)init {
    if (self = [super init]) {
        [self _setupCoreData];
    }
    return self;
}

- (void)_setupCoreData {
    [MagicalRecord setupAutoMigratingCoreDataStack];
}

#pragma mark -

@end
