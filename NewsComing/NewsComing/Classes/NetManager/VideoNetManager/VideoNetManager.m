//
//  VideoNetManager.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "VideoNetManager.h"


@implementation VideoNetManager

+ (id)getVideoWithPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html", page];
    return [self get:path params:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([VideoModel mj_objectWithKeyValues:responseObj], error);
    }];
}
@end
