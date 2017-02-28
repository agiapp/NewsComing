//
//  BaseViewModel.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionHandler)(NSError *error);

@protocol BaseViewModelDelegate <NSObject>

@optional
/** 获取数据 */
- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler;
/** 刷新 */
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler;
/** 获取更多 */
- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler;

@end

@interface BaseViewModel : NSObject <BaseViewModelDelegate>

@property (strong, nonatomic) NSMutableArray *dataMArr;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

/** 取消任务 */
- (void)cacelTask;
/** 暂停任务 */
- (void)suspendTask;
/** 继续任务 */
- (void)resumeTask;

@end
