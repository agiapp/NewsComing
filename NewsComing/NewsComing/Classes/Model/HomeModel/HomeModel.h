//
//  HomeModel.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "BaseModel.h"

@class HomeResultModel,HomeResultHeadlineinfoModel,HomeResultTopnewsinfoModel,HomeResultNewslistModel,HomeResultFocusimgModel;

@interface HomeModel : BaseModel

@property (nonatomic, strong) HomeResultModel *result;

@property (nonatomic, assign) NSInteger returncode;

@property (nonatomic, copy) NSString *message;

@end

@interface HomeResultModel : BaseModel

@property (nonatomic, assign) BOOL isloadmore;

@property (nonatomic, assign) NSInteger rowcount;

@property (nonatomic, strong) HomeResultHeadlineinfoModel *headlineinfo;

@property (nonatomic, strong) NSArray<HomeResultFocusimgModel *> *focusimg;

@property (nonatomic, strong) NSArray<HomeResultNewslistModel *> *newslist;

@property (nonatomic, strong) HomeResultTopnewsinfoModel *topnewsinfo;

@end

@interface HomeResultHeadlineinfoModel : BaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *smallpic;

@property (nonatomic, assign) NSInteger replycount;

@property (nonatomic, copy) NSString *lasttime;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger mediatype;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, assign) NSInteger jumppage;

@property (nonatomic, copy) NSString *indexdetail;

@property (nonatomic, assign) NSInteger pagecount;

@property (nonatomic, strong) NSArray *coverimages;

@end

@interface HomeResultTopnewsinfoModel : BaseModel

@end

@interface HomeResultNewslistModel : BaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray *coverimages;

@property (nonatomic, copy) NSString *smallpic;

@property (nonatomic, assign) NSInteger replycount;

@property (nonatomic, copy) NSString *lasttime;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger mediatype;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, assign) NSInteger jumppage;

@property (nonatomic, copy) NSString *indexdetail;

@property (nonatomic, assign) NSInteger pagecount;

@property (nonatomic, assign) NSInteger anewstype;

@end

@interface HomeResultFocusimgModel : BaseModel

@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *jumpurl;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger replycount;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger pageindex;

@property (nonatomic, assign) NSInteger JumpType;

@property (nonatomic, assign) NSInteger mediatype;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger fromtype;

@end
