//
//  WordViewModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordViewModel.h"

@implementation WordViewModel

- (NSInteger)rowNum {
    return self.dataMArr.count;
}

- (WordModel *)modelForRow:(NSInteger)row {
    return self.dataMArr[row];
}

- (NSString *)contentForRow:(NSInteger)row {
    return [@"        " stringByAppendingString:[self modelForRow:row].text];
}

- (NSString *)zanNumForRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%ld", [self modelForRow:row].zan];
}

- (NSString *)dateForRow:(NSInteger)row {
    return [self modelForRow:row].created_at;
}

- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler {
    self.dataTask = [WordNetManager getWordWithPage:self.page completionHandler:^(id model, NSError *error) {
        if (!error) {
            if (self.page == 1) {
                [self.dataMArr removeAllObjects];
            }
            [self.dataMArr addObjectsFromArray:model];
        }
        completionHandler(error);
    }];
}

- (void)refreshDataCompletionHandler:(completionHandler)completionHandler {
    self.page = 1;
    [self getDataFromNetCompletionHandler:completionHandler];
}

- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler {
    self.page += 1;
    [self getDataFromNetCompletionHandler:completionHandler];
}

@end
