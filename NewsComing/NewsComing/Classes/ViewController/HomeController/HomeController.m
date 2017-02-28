//
//  HomeController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeController.h"
#import "HomeListController.h"

@interface HomeController ()

@end

@implementation HomeController

+ (UINavigationController *)defaultHomeNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HomeController *vc = [[HomeController alloc] initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
        navi = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return navi;
}

+ (NSArray *)itemNames {
    return @[@"最新",@"新闻",@"评测",@"导购",@"用车",@"技术",@"文化",@"改装",@"游记",];
}

+ (NSArray *)viewControllerClasses {
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i < [self itemNames].count; i++) {
        [mArr addObject:[HomeListController class]];
    }
    return [mArr copy];
}

+ (NSArray *)vcKeys {
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i < [self itemNames].count; i++) {
        [mArr addObject:@"infoType"];
    }
    return [mArr copy];
}

+ (NSArray *)vcValues {
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i < [self itemNames].count; i++) {
        [mArr addObject:@(i)];
    }
    return [mArr copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻来了";
}

@end
