//
//  LVCNetworkProxy.h
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

@import Foundation;

@class AFHTTPSessionManager;
@class RACSignal;

typedef NS_ENUM(NSUInteger, LVCNetworkProxyHTTPMethod) {
    LVCNetworkProxyHTTPMethodGET,
    LVCNetworkProxyHTTPMethodPOST,
    LVCNetworkProxyHTTPMethodPUT,
    LVCNetworkProxyHTTPMethodDELETE,
};


@interface LVCNetworkProxy : NSObject


/// @abstract Builds a LVCNetworkProxy with the default configuration.
+ (instancetype)defaultProxy;

/// @abstract For customization or testing purposes. Use convenience initializer '+ defaultProxy' for default configuration.
- (instancetype)initWithAFHTTPSessionManager:(AFHTTPSessionManager *)sessionManager;

/// @abstract Performs a network request on a background thread.
/// @warning The response event is executed on the main thread.
///          You may call '- deliverOn:[RACScheduler scheduler]' after the signal
///          to handle response data on a background thread and, once the data
///          has been parsed, return to the main thead (e.g. '- deliverOn:[RACScheduler mainThreadScheduler]').
/// @return RACSignal Next: (NSDictionary *)JSON.
- (RACSignal *)performRequestWithMethod:(LVCNetworkProxyHTTPMethod)HTTPMethod onRESTPath:(NSString *)path withParams:(NSDictionary *)params;

@end
