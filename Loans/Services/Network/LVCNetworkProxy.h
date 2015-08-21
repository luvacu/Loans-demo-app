//
//  LVCNetworkProxy.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

@class RACSignal;

typedef NS_ENUM(NSUInteger, LVCNetworkProxyHTTPMethod) {
    LVCNetworkProxyHTTPMethodGET,
    LVCNetworkProxyHTTPMethodPOST,
    LVCNetworkProxyHTTPMethodPUT,
    LVCNetworkProxyHTTPMethodDELETE,
};

@interface LVCNetworkProxy : NSObject

+ (instancetype)sharedProxy;

/// @return RACSignal Next: (NSDictionary *)JSON
- (RACSignal *)performRequestWithMethod:(LVCNetworkProxyHTTPMethod)HTTPMethod onRESTPath:(NSString *)path withParams:(NSDictionary *)params;

@end
