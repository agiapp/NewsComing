//
//  PicNetManager.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "PicNetManager.h"

@implementation PicNetManager

+ (id)getPicWithSetID:(NSInteger)setID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"http://c.3g.163.com/photo/api/morelist/0096/4GJ60096/%ld.json", setID];
    return [self get:path params:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([PicModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

@end
