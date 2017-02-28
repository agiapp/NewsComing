//
//  WordNetManager.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordNetManager.h"

@implementation WordNetManager

+ (id)getWordWithPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"http://joke.luckyamy.com/api/?cat=dz&p=%ld&ap=ymds&ver=1.6", page];
    return [self get:path params:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([WordModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

@end
