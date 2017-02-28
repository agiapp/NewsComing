//
//  HomeViewModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)initWithType:(NewsListType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert1(NO, @"%s 必须使用initWithType方法初始化", __func__);
    }
    return self;
}

- (NSInteger)rowNum {
    return self.dataMArr.count;
}

- (HomeResultNewslistModel *)modelForRow:(NSInteger)row {
    return self.dataMArr[row];
}
- (NSURL *)iconURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].smallpic];
}
- (NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].title;
}
- (NSString *)dateForRow:(NSInteger)row {
    return [self modelForRow:row].time;
}
- (NSString *)commentNumForRow:(NSInteger)row {
    if ([self mediaTypeForRow:row] == 3) {
        return [NSString stringWithFormat:@"%ld播放", [self modelForRow:row].replycount];
    }else {
        return [NSString stringWithFormat:@"%ld评论",[self modelForRow:row].replycount];
    }
}
- (NSInteger)IDForRow:(NSInteger)row {
    return [self modelForRow:row].ID;
}

- (NSInteger)mediaTypeForRow:(NSInteger)row {
    return [self modelForRow:row].mediatype;
}

- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler {
    self.dataTask = [HomeNetManager getNewsListType:self.type lastTime:self.updateTime page:self.page completionHandler:^(HomeModel *model, NSError *error) {
        if (!error) {
            if (self.page == 1) {
                [self.dataMArr removeAllObjects];
                NSMutableArray *mArr = [NSMutableArray new];
                for (HomeResultFocusimgModel *obj in model.result.focusimg) {
                    [mArr addObject:obj.imgurl];
                }
                self.headImgURLs = [mArr copy];
            }
            [self.dataMArr addObjectsFromArray:model.result.newslist];
        }
        completionHandler(error);
    }];
}
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler {
    self.page = 1;
    self.updateTime = @"0";
    [self getDataFromNetCompletionHandler:completionHandler];
}
- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler {
    self.page += 1;
    HomeResultNewslistModel * model = self.dataMArr.lastObject;
    self.updateTime = model.lasttime;
    [self getDataFromNetCompletionHandler:completionHandler];
}

- (BOOL)hasHeadImg {
    return self.headImgURLs.count != 0;
}

@end
