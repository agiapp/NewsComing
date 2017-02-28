//
//  HomeDetailController.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailController : UIViewController

/** 初始化的时候把ID传进来 */
- (instancetype)initWithID:(NSInteger)ID;
@property (nonatomic) NSInteger ID;

@end
