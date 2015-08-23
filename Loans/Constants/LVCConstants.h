//
//  LVCConstants.h
//  Loans
//
//  Created by Luis Valdés on 23/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

/// Never use this class' methods & properties directly,
/// instead, use the MACRO defined at the bottom
@interface LVCConstants : NSObject

@property (nonatomic, readonly) NSBundle *resourceBundle;
@property (nonatomic, readonly) NSString *filename;

+ (id)sharedManager;
- (void)setPlist:(NSString *)filename bundle:(NSBundle *)bundle;

- (NSString *)localizedStringForKey:(NSString *)key domain:(NSString *)domain;

@end

#define LVCConstantsValue(key, domainName) \
[[LVCConstants sharedManager] localizedStringForKey:(key) domain:(domainName)]
