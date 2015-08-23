//
//  LVCConstants.m
//  Loans
//
//  Created by Luis Valdés on 23/8/15.
//  Copyright (c) 2015 Luis Valdés Cuesta. All rights reserved.
//

#import "LVCConstants.h"

@interface LVCConstants () {
    NSBundle *_resourceBundle;
    NSDictionary *_dictionary;
    NSString *_filename;
}
@end

@implementation LVCConstants

+ (id)sharedManager {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setPlist:@"APIConstants.plist" bundle:nil];
    });
    return sharedInstance;
}

- (void)setPlist:(NSString *)filename bundle:(NSBundle *)bundle {
	if (bundle) {
		_resourceBundle = bundle;
	} else {
		_resourceBundle = [NSBundle mainBundle];
	}
	_filename   = filename;
	_dictionary = [self plistDictionary];
}

- (NSString *)localizedStringForKey:(NSString *)key domain:(NSString *)domain {
	NSDictionary *domainDict;
	if (domain) {
		domainDict = [_dictionary valueForKeyPath:domain];
	} else {
		domainDict = _dictionary;
	}
	return [domainDict objectForKey:key];
}

#pragma mark - Private methods

- (NSDictionary *)plistDictionary {
	NSString *plistPath;
	if ([_filename hasSuffix:@".plist"]) {
		plistPath = [_resourceBundle pathForResource:_filename ofType:nil];
	} else {
		plistPath = [_resourceBundle pathForResource:_filename ofType:@"plist"];
	}
	return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

@end
