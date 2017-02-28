//
//  AppDelegate+DDLog.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "AppDelegate+DDLog.h"

@implementation AppDelegate (DDLog)

- (void)initializeWithApplication:(UIApplication *)application {
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

@end
