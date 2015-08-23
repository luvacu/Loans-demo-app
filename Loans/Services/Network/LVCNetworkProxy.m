//
//  LVCNetworkProxy.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCNetworkProxy.h"
#import "LVCConstantsManager.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import <ReactiveCocoa/ReactiveCocoa.h>


NSString * const LVCNetworkProxyErrorDomain = @"es.valdes.luis.services.network.proxy.error";

NSString *NSStringFromLVCNetworkProxyHTTPMethod(LVCNetworkProxyHTTPMethod method) {
    NSDictionary *methodDictionary = @{@(LVCNetworkProxyHTTPMethodGET):      @"GET",
                                       @(LVCNetworkProxyHTTPMethodPOST):     @"POST",
                                       @(LVCNetworkProxyHTTPMethodPUT):      @"PUT",
                                       @(LVCNetworkProxyHTTPMethodDELETE):   @"DELETE",};
    return methodDictionary[@(method)];
}

@interface LVCNetworkProxy()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation LVCNetworkProxy

#pragma mark - Public API

+ (instancetype)sharedProxy {
    static id _sharedProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProxy = [[[self class] alloc] init];
    });
    return _sharedProxy;
}

/// @return RACSignal Next: (NSDictionary *)JSON.
- (RACSignal *)performRequestWithMethod:(LVCNetworkProxyHTTPMethod)HTTPMethod onRESTPath:(NSString *)path withParams:(NSDictionary *)params {
    // Sanitize path string
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        // Success block
        void (^successBlock)(NSURLSessionDataTask *task, id responseObject) = [self _buildSuccessBlockWithMethod:HTTPMethod
                                                                                                            path:path
                                                                                                          params:params
                                                                                                      subscriber:subscriber];
        // Failure block
        void (^failureBlock)(NSURLSessionDataTask *task, NSError *error) = [self _buildFailureBlockWithSubscriber:subscriber];
        
        // Launch network request depending on HTTP method
        NSURLSessionDataTask *task;
        switch (HTTPMethod) {
            case LVCNetworkProxyHTTPMethodGET:
                task = [self.sessionManager GET:path parameters:params success:successBlock failure:failureBlock];
                break;
            case LVCNetworkProxyHTTPMethodPOST:
                task = [self.sessionManager POST:path parameters:params success:successBlock failure:failureBlock];
                break;
            case LVCNetworkProxyHTTPMethodPUT:
                task = [self.sessionManager PUT:path parameters:params success:successBlock failure:failureBlock];
                break;
            case LVCNetworkProxyHTTPMethodDELETE:
                task = [self.sessionManager DELETE:path parameters:params success:successBlock failure:failureBlock];
                break;
                
            default:
                task = nil;
                NSLog(@"Invalid HTTP method");
                break;
        }
        
        // If you return 'nil' instead of a 'RACDisposable', it will make this RACSignal NOT cancelable
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return [[[signal
              doError:^(NSError *error) {
                  NSLog(@"Error performing %@ on REST path '%@' | Params: %@. Error: %@",
                        NSStringFromLVCNetworkProxyHTTPMethod(HTTPMethod), path, params, error);
              }]
              publish] autoconnect];
    /**
     * '[signal publish]' returns a RACMulitcastConnection
     * that will prevent executing the signal's block for each new subscriber.
     * The work will be performed once even if there are multiple subscribers. 
     * Then, every subscriber will receive the events. 
     * 'autoconnect' connects to the underlying signal when the signal it returns 
     * is subscribed to.
     * We are returning a 'cold' (work is not performed until the first subscription),
     * 'multicasted'(work is performed only once, but results multicasted) signal.
     */
}

#pragma mark - Private methods

- (instancetype)init {
    if (self = [super init]) {
        [self _initSessionManager];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

- (void)_initSessionManager {
    NSURL *url = [NSURL URLWithString:[LVCConstantsManager APIEndPoint]];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
}

+ (NSError *)_errorWithLocalizedDescription:(NSString *)localizedDescription {
    return [NSError errorWithDomain:LVCNetworkProxyErrorDomain
                               code:0
                           userInfo:@{ NSLocalizedDescriptionKey: localizedDescription }];
}

- (void (^)(NSURLSessionDataTask *task, id responseObject))_buildSuccessBlockWithMethod:(LVCNetworkProxyHTTPMethod)HTTPMethod
                                                                                   path:(NSString *)path
                                                                                 params:(NSDictionary *)params
                                                                             subscriber:(id<RACSubscriber>)subscriber {
    return ^void(NSURLSessionDataTask *task, id responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200 && responseObject && [responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *json = responseObject;
            NSLog(@"%@: %@ | Params: %@. JSON received: %@", NSStringFromLVCNetworkProxyHTTPMethod(HTTPMethod), path, params, json);
            [subscriber sendNext:json];
            [subscriber sendCompleted];
        } else {
            NSError *error = [LVCNetworkProxy _errorWithLocalizedDescription:
                              @"No response object found, unexpected format, or invalid request"];
            [subscriber sendError:error];
        }
    };
}

- (void (^)(NSURLSessionDataTask *task, NSError *error))_buildFailureBlockWithSubscriber:(id<RACSubscriber>)subscriber {
    return ^void(NSURLSessionDataTask *task, NSError *error) {
        [subscriber sendError:error];
    };
}

#pragma mark -

@end

