//
//  AppDelegate.m
//  NewsComing
//
//  Created by 任波 on 16/3/1.
//  Copyright © 2016年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#import "AppDelegate.h"
#import "AppDelegate+DDLog.h"
#import "HomeController.h"
#import "WordController.h"
#import "VideoController.h"
#import "MyController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

//友盟
//#define kAppKey  @"5632e65ae0f55a556a0013d9"
//#define kURL     @"http://www.umeng.com/social"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeWithApplication:application];
    
    
    [NSThread sleepForTimeInterval:2];
    
    [self configGlobalUIStyle];
    
    //[UMSocialData setAppKey:kAppKey];
    //[UMSocialWechatHandler setWXAppId:@"wx945b58aef3a271f0" appSecret:@"0ae78dd42761fd9681b04833c79a857b" url:kURL];
    
    [Bmob registerWithAppKey:@"160f7c6245ab95cfef879bf663e2fd32"];
    
    [self setupViewControllers];
    
    self.window.rootViewController = self.tabBarController;
    
    return YES;
}

/** 配置导航栏 */
- (void)configGlobalUIStyle {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"backgroundImage"] forBarMetrics:UIBarMetricsDefault];
    bar.translucent = NO;
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldFlatFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)setupViewControllers {
    UINavigationController *navi0 = [HomeController defaultHomeNavi];
    UINavigationController *navi1 = [WordController defaultWordNavi];
    UINavigationController *navi2 = [VideoController defaultVideoNavi];
    UINavigationController *vc3 = [MyController defaultMyNavi];
    CYLTabBarController *tbc = [CYLTabBarController new];
    [self customTabBarForController:tbc];
    [tbc setViewControllers:@[navi0,navi1,navi2,vc3]];
    self.tabBarController = tbc;
    
}

- (void)customTabBarForController:(CYLTabBarController *)tbc {
    NSDictionary *dict0 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:@"news",
                            CYLTabBarItemSelectedImage:@"newsblue"};
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"图文",
                            CYLTabBarItemImage:@"live",
                            CYLTabBarItemSelectedImage:@"liveblue"};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"视频",
                            CYLTabBarItemImage:@"market",
                            CYLTabBarItemSelectedImage:@"marketblue"};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:@"my",
                            CYLTabBarItemSelectedImage:@"myblue"};
    NSArray *tabBarItemsAttributes = @[dict0,dict1,dict2,dict3];
    tbc.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (UIWindow *)window {
    if(_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (UITabBarController *)tabBarController {
    if(_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    return _tabBarController;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}

@end
