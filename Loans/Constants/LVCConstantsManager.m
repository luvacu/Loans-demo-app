//
//  LVCConstantsManager.m
//  Loans
//
//  Created by Luis Valdés on 23/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCConstantsManager.h"
#import "LVCConstants.h"

@implementation LVCConstantsManager

#pragma mark - API

+ (NSString *)APIEndPoint {
    return LVCConstantsValue(@"APIEndPoint", nil);
}

#pragma mark - API - Paths

+ (NSString *)APIPathLoansSearch {
    return LVCConstantsValue(@"APIPathLoansSearch", @"APIPaths");
}

#pragma mark - Images

+ (NSString *)imagesEndPoint {
    return LVCConstantsValue(@"ImagesEndPoint", nil);
}

#pragma mark - Images - Paths

+ (NSString *)imagePath {
    return LVCConstantsValue(@"ImagePath", @"ImagesPaths");
}

#pragma mark -

@end
