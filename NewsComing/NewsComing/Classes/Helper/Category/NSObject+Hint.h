//
//  NSObject+Hint.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hint)

/** 显示加载 */
- (void)showLoad;
/** 加载完毕 */
- (void)hideLoad;

/** 显示成功（及提示文字） */
- (void)showSuccessWithMsg:(NSObject *)msg;
/** 显示错误（及提示文字） */
- (void)showErrorWithMsg:(NSObject *)msg;

@end
