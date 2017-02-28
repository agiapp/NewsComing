//
//  HomeModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

@end

@implementation HomeResultModel

/** 属性为数组 对应相应的解析类 */
+ (NSDictionary *)objectClassInArray{
    return @{@"newslist" : [HomeResultNewslistModel class], @"focusimg" : [HomeResultFocusimgModel class]};
}

@end

@implementation HomeResultHeadlineinfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end

@implementation HomeResultTopnewsinfoModel

@end

@implementation HomeResultNewslistModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id", @"anewstype":@"newstype"};
}

@end

@implementation HomeResultFocusimgModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end
