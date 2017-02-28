//
//  HomeNetManager.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseNetManager.h"
#import "HomeModel.h"

typedef NS_ENUM(NSUInteger, NewsListType) {
    NewsListTypeZuiXin,  //最新
    NewsListTypeXinWen,     //新闻
    NewsListTypePingCe,     //评测
    NewsListTypeDaoGou,     //导购
    NewsListTypeYongChe,    //用车
    NewsListTypeJiShu,      //技术
    NewsListTypeWenHua,     //文化
    NewsListTypeGaiZhuang,  //改装
    NewsListTypeYouJi,      //游记
};

@interface HomeNetManager : BaseNetManager

+ (id)getNewsListType:(NewsListType)type lastTime:(NSString *)lastTime page:(NSInteger)page kCompletionHandler;

@end
