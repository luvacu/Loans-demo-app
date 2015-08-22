//
//  LVCImageHelper.h
//  Loans
//
//  Created by Luis Valdés on 22/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LVCImageHelper : NSObject

+ (instancetype)sharedHelper;

- (NSURL *)URLForImageId:(NSNumber *)imageId withSize:(NSUInteger)size;

@end
