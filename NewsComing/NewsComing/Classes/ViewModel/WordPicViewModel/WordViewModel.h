//
//  WordViewModel.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseViewModel.h"
#import "WordNetManager.h"

@interface WordViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNum;

- (NSString *)contentForRow:(NSInteger)row;
- (NSString *)zanNumForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;

@property (nonatomic) NSInteger page;

@end
