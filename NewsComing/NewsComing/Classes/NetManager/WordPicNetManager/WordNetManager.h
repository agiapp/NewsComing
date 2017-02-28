//
//  WordNetManager.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseNetManager.h"
#import "WordModel.h"

@interface WordNetManager : BaseNetManager

+ (id)getWordWithPage:(NSInteger)page kCompletionHandler;

@end
