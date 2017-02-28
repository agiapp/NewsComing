//
//  BmobCloud.h
//  BmobSDK
//
//  Created by Bmob on 13-12-31.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

@interface BmobCloud : NSObject


/**
*  同步调用云函数，请在子线程使用
*
*  @param function   函数名
*  @param parameters 传递给函数的参数
*
*  @return 云端代码结果
*/
+(id)callFunction:(NSString *)function withParameters:(NSDictionary *)parameters;


/**
 *  同步调用云函数，请在子线程使用
 *
 *  @param function   函数名
 *  @param parameters 传递给函数的参数
 *  @param error      错误信息
 *
 *  @return 云端代码结果
 */
+(id)callFunction:(NSString *)function withParameters:(NSDictionary *)parameters error:(NSError **)error;

/**
 *  异步调用云函数
 *
 *  @param function   函数名
 *  @param parameters 传递给函数的参数
 *  @param block      云函数响应结果跟信息
 */
+(void)callFunctionInBackground:(NSString *)function withParameters:(NSDictionary *)parameters block:(BmobIdResultBlock)block;

@end
