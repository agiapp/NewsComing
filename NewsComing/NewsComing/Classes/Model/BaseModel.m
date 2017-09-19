//
//  BaseModel.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
/**
    之前将数据保存本地，只能是字符串、数组、字典、NSNuber、BOOL等容器类对象对象，不能将所有对象都给保存，而采用归档能将所有的对象转化为二进制数据保存在文件中，并通过解归档让将文件里面保存的数据读取出来
    
    所谓归档:将复杂对象转化为NSData类型数据(复杂-->归档-->NSData--->WriteToFile)
    注意:归档是将对象转化为数据字节,以文件的形式存储在磁盘上,
    所谓反归档:将NSData类型数据转化为复杂对象(读取文件-->NSData-->反归档--->复杂对象)
 
 */
// NSCoding实现 属性归档和反归档的操作

MJCodingImplementation

@end
