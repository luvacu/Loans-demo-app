//
//  LVCImageHelper.m
//  Loans
//
//  Created by Luis Valdés on 22/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCImageHelper.h"
#import "LVCConstantsManager.h"


@interface LVCImageHelper()

@property (strong, nonatomic) NSURL *baseURL;

@end

@implementation LVCImageHelper

#pragma mark - Public API

+ (instancetype)sharedHelper {
    static id _sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [[[self class] alloc] init];
    });
    return _sharedHelper;
}

- (NSURL *)URLForImageId:(NSNumber *)imageId withSize:(NSUInteger)size {
    NSParameterAssert(imageId && size > 0);
    NSString *path = [NSString stringWithFormat:[LVCConstantsManager imagePath], @(size), imageId];
    return [NSURL URLWithString:path relativeToURL:self.baseURL];
}

#pragma mark - Private methods

- (instancetype)init {
    if (self = [super init]) {
        self.baseURL = [NSURL URLWithString:[LVCConstantsManager imagesEndPoint]];
    }
    return self;
}

#pragma mark -

@end
