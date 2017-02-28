//
//  PicViewModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "PicViewModel.h"

@implementation PicViewModel

- (NSInteger)rowNum {
    return self.dataMArr.count;
}

- (PicModel *)modelForRow:(NSInteger)row {
    return self.dataMArr[row];
}

- (NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].setname;
}
- (NSString *)browseNumForRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%@浏览", [self modelForRow:row].replynum];
}
- (NSArray *)iconURLsForRow:(NSInteger)row {
    return [self modelForRow:row].pics;
}

- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler {
    self.dataTask = [PicNetManager getPicWithSetID:self.setID completionHandler:^(id model, NSError *error) {
        if (self.setID == 82259) {
            [self.dataMArr removeAllObjects];
        }
        [self.dataMArr addObjectsFromArray:model];
        completionHandler(error);
    }];
}
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler {
    self.setID = 82259;
    [self getDataFromNetCompletionHandler:completionHandler];
}
-(void)getMoreDataCompletionHandler:(completionHandler)completionHandler {
    PicModel *model = self.dataMArr.lastObject;
    self.setID = model.setid.integerValue;
    [self getDataFromNetCompletionHandler:completionHandler];
}

@end
