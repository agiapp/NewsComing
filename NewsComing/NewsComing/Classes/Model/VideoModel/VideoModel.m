//
//  VideoModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

/** 属性为数组 对应相应的解析类 */
+ (NSDictionary *)objectClassInArray{
    return @{@"videoSidList" : [VideoVideosidlistModel class], @"videoList" : [VideoVideolistModel class]};
}

@end

@implementation VideoVideosidlistModel

@end

@implementation VideoVideolistModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"desc":@"description"};
}

@end
