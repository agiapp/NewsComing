//
//  HomeDetailController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeDetailController.h"

@interface HomeDetailController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation HomeDetailController

- (instancetype)initWithID:(NSInteger)ID {
    if (self = [super init]) {
        self.ID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [BarItem addBackItemToVC:self];
    self.title = @"新闻详情";
    [self webView];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self hideLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self hideLoad];
}

#pragma mark - 懒加载
- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        NSString *path = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newscontent-n%ld-t0-rct1.json", self.ID];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    }
    return _webView;
}

@end
