//
//  WordCell.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

- (UILabel *)contentLB {
    if(_contentLB == nil) {
        _contentLB = [[UILabel alloc] init];
        _contentLB.font = kTitleFont;
        _contentLB.numberOfLines = 0;
        [self.contentView addSubview:_contentLB];
        [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
        }];
    }
    return _contentLB;
}

- (UIButton *)zanBtn {
    if(_zanBtn == nil) {
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _zanBtn.titleLabel.font = kSubtitleFont;
        [_zanBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        _zanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [self.contentView addSubview:_zanBtn];
        [_zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.contentLB.mas_bottom).mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.bottom.mas_equalTo(-5);
        }];
    }
    return _zanBtn;
}

- (UILabel *)dateLB {
    if(_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        _dateLB.font = kSubtitleFont;
        _dateLB.textColor = [UIColor lightGrayColor];
        _dateLB.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dateLB];
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.zanBtn);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(130);
        }];
    }
    return _dateLB;
}


@end
