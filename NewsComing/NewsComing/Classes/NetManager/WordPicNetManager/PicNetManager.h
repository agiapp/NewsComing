//
//  PicNetManager.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseNetManager.h"
#import "PicModel.h"

@interface PicNetManager : BaseNetManager

+ (id)getPicWithSetID:(NSInteger)setID kCompletionHandler;

@end
