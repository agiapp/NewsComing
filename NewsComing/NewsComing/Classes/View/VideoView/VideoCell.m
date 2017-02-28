//
//  VideoCell.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (UILabel *)titleLB {
    if(_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = kTitleFont;
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
        }];
    }
    return _titleLB;
}

- (MyImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[MyImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(200);
        }];
    }
    return _iconIV;
}

- (UILabel *)subtitleLB {
    if(_subtitleLB == nil) {
        _subtitleLB = [[UILabel alloc] init];
        _subtitleLB.font = kSubtitleFont;
        _subtitleLB.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_subtitleLB];
        [_subtitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(kWindowW/4*3);
            make.top.mas_equalTo(self.iconIV.mas_bottom).mas_equalTo(10);
        }];
    }
    return _subtitleLB;
}

- (UILabel *)timeLB {
    if(_timeLB == nil) {
        _timeLB = [[UILabel alloc] init];
        _timeLB.font = kSubtitleFont;
        _timeLB.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLB];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(40);
            make.centerY.mas_equalTo(self.subtitleLB);
        }];
        MyImageView *timeIV = [MyImageView new];
        timeIV.imgView.image = [UIImage imageNamed:@"time"];
        [self.contentView addSubview:timeIV];
        [timeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.subtitleLB);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.right.mas_equalTo(_timeLB.mas_left).mas_equalTo(-3);
        }];
    }
    return _timeLB;
}

@end
