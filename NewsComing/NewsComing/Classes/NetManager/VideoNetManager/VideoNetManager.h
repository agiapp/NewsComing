//
//  VideoNetManager.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseNetManager.h"
#import "VideoModel.h"

@interface VideoNetManager : BaseNetManager

+ (id)getVideoWithPage:(NSInteger)page kCompletionHandler;

@end
