//
//  BaseNetManager.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#import "BaseNetManager.h"

@implementation BaseNetManager

+ (AFHTTPSessionManager *)defaultAFManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}

+ (id)get:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSLog(@"path: %@, params: %@", path, params);
    return [[self defaultAFManager] GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error];
        completionHandler(nil, error);
    }];
}

+ (void)handleError:(NSError *)error  {
    //弹出错误信息
    [[self new] showErrorWithMsg:error];
}

+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params {
    NSMutableString *percentPath = [NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else {
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
