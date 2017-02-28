//
//  RegisterLoginController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "RegisterLoginController.h"
#import "RegisterController.h"
#import "MyController.h"

@interface RegisterLoginController ()

@property (strong, nonatomic) UITextField *passwdTF;

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIBarButtonItem *registerItem;

@end

@implementation RegisterLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"个人资料";
    [BarItem addBackItemToVC:self];
    self.view.backgroundColor = kRGBColor(236, 236, 236);
    
    [self usernameTF];
    [self passwdTF];
    [self loginBtn];
    self.navigationItem.rightBarButtonItem = self.registerItem;
}

#pragma mark - 懒加载
- (UIButton *)loginBtn {
    if(_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:5];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:kRGBColor(27, 116, 194)];
        [self.view addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [_loginBtn bk_addEventHandler:^(id sender) {
            
            [BmobUser loginWithUsernameInBackground:self.usernameTF.text password:self.passwdTF.text block:^(BmobUser *user, NSError *error) {
                if (user) {
                    MyController *vc = [MyController new];
                    vc.label.text = self.usernameTF.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    if ([self.usernameTF.text isEqualToString:@""] && [self.passwdTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入用户名和密码"];
                    }else if ([self.passwdTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入密码"];
                    }else if ([self.usernameTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入用户名"];
                    }else {
                        [self showSuccessWithMsg:@"请先注册"];
                    }
                }
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UITextField *)usernameTF {
    if(_usernameTF == nil) {
        _usernameTF = [[UITextField alloc] init];
        _usernameTF.borderStyle = UITextBorderStyleRoundedRect;
        _usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTF.backgroundColor = [UIColor whiteColor];
        _usernameTF.placeholder = @"    请输入您的用户名";
        [self.view addSubview:_usernameTF];
        [_usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _usernameTF;
}

- (UITextField *)passwdTF {
    if(_passwdTF == nil) {
        _passwdTF = [[UITextField alloc] init];
        _passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        _passwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwdTF.secureTextEntry = YES;
        _passwdTF.placeholder = @"    请输入您的密码";
        _passwdTF.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_passwdTF];
        [_passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.usernameTF.mas_bottom).mas_equalTo(2);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _passwdTF;
}

- (UIBarButtonItem *)registerItem {
    if(_registerItem == nil) {
        _registerItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"注册" style:UIBarButtonItemStyleDone handler:^(id sender) {
            RegisterController *vc = [RegisterController new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        _registerItem.tintColor = [UIColor whiteColor];
    }
    return _registerItem;
}

@end
