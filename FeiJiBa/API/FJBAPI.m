//
//  FJBAPI.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "FJBAPI.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"http://42.99.16.17:8080/";

@implementation FJBAPI

+ (instancetype)shareFJBAPI {
    static FJBAPI *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FJBAPI alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


@end
