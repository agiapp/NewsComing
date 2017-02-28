//
//  PicViewModel.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseViewModel.h"
#import "PicNetManager.h"

@interface PicViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNum;


- (NSArray *)iconURLsForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)browseNumForRow:(NSInteger)row;

@property (nonatomic) NSInteger setID;

- (PicModel *)modelForRow:(NSInteger)row;

@end
