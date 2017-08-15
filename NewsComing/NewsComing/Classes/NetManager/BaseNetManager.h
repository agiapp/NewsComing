//
//  BaseNetManager.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#import <Foundation/Foundation.h>

#define kCompletionHandler completionHandler:(void(^)(id model, NSError *error))completionHandler

@interface BaseNetManager : NSObject

/** 封装AFHTTPSessionManager的GET请求方法*/
+ (id)get:(NSString *)path params:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

/**
 *  有的服务器对于中文字符串不支持，需要转化字符串为带有%号形式
 *
 *  @param path  请求的路径
 *  @param paras 请求的参数
 *
 *  @return 拼接出的字符串中的中文为%号形势（路径+参数）
 */
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params;

@end
