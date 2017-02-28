//
//  VideoController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "VideoController.h"
#import "VideoCell.h"
#import "VideoViewModel.h"

@interface VideoController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) VideoViewModel *videoVM;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation VideoController

+ (UINavigationController *)defaultVideoNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        VideoController *vc = [VideoController new];
        navi = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconIV.imgView setImageWithURL:[self.videoVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    MyImageView *playIV = [MyImageView new];
    playIV.imgView.image = [UIImage imageNamed:@"play"];
    [cell.iconIV addSubview:playIV];
    [playIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    cell.titleLB.text = [self.videoVM titleForRow:indexPath.row];
    cell.subtitleLB.text = [self.videoVM subtitleForRow:indexPath.row];
    cell.timeLB.text = [self.videoVM timeForRow:indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    AVPlayerViewController *vc = [AVPlayerViewController new];
    AVPlayer *player = [AVPlayer playerWithURL:[self.videoVM videoURLForRow:indexPath.row]];
    vc.player = player;
    [self presentViewController:vc animated:YES completion:nil];
    [vc.player play];
}

#pragma mark - 懒加载
- (VideoViewModel *)videoVM {
    if(_videoVM == nil) {
        _videoVM = [[VideoViewModel alloc] init];
    }
    return _videoVM;
}
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[VideoCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.videoVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.videoVM getMoreDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_footer endRefreshing];
            }];
        }];
    }
    return _tableView;
}

@end
