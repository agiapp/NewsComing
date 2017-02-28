//
//  VideoViewModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "VideoViewModel.h"

@implementation VideoViewModel

- (NSInteger)rowNum {
    return self.dataMArr.count;
}

- (VideoVideolistModel *)modelForRow:(NSInteger)row {
    return self.dataMArr[row];
}
- (NSURL *)iconURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].cover];
}
- (NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].title;
}
- (NSString *)subtitleForRow:(NSInteger)row {
    return [self modelForRow:row].desc;
}
- (NSString *)timeForRow:(NSInteger)row {
    NSInteger length = [self modelForRow:row].length;
    if (length >= 60) {
        return [NSString stringWithFormat:@"%02ld:%02ld", length/60, length%60];
    }else {
        return [NSString stringWithFormat:@"00:%02ld", length];
    }
}

- (NSURL *)videoURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].mp4_url];
}

- (void)getDataFromNetCompleteHandler:(completionHandler)completionHandler {
    self.dataTask = [VideoNetManager getVideoWithPage:self.page completionHandler:^(VideoModel *model, NSError *error) {
        if (!error) {
            if (self.page == 0) {
                [self.dataMArr removeAllObjects];
            }
            [self.dataMArr addObjectsFromArray:model.videoList];
        }
        completionHandler(error);
    }];
}
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler {
    self.page = 0;
    [self getDataFromNetCompleteHandler:completionHandler];
}
- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler {
    self.page += 10;
    [self getDataFromNetCompleteHandler:completionHandler];
}

@end
