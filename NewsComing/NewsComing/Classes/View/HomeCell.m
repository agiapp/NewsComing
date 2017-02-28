//
//  HomeCell.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (MyImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[MyImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(80, 60));
            make.centerY.mas_equalTo(0);
        }];
    }
    return _iconIV;
}

- (UILabel *)titleLB {
    if(_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = kTitleFont;
        _titleLB.numberOfLines = 0;
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconIV.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(self.iconIV);
        }];
    }
    return _titleLB;
}

- (UILabel *)dateLB {
    if(_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        _dateLB.font = kSubtitleFont;
        _dateLB.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_dateLB];
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLB);
            make.width.mas_equalTo(80);
            make.bottomMargin.mas_equalTo(self.iconIV);
        }];
    }
    return _dateLB;
}

- (UILabel *)commentNumLB {
    if(_commentNumLB == nil) {
        _commentNumLB = [[UILabel alloc] init];
        _commentNumLB.font = kSubtitleFont;
        _commentNumLB.textColor = [UIColor lightGrayColor];
        _commentNumLB.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_commentNumLB];
        [_commentNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.dateLB);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(80);
        }];
    }
    return _commentNumLB;
}


@end
