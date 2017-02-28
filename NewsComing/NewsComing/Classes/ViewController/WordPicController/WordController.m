//
//  WordController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordController.h"
#import "WordViewModel.h"
#import "PicController.h"
#import "WordCell.h"
#import "WordDetailController.h"

@interface WordController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UISegmentedControl *sc;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) WordViewModel *wordVM;

@end

@implementation WordController

+ (UINavigationController *)defaultWordNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WordController *vc = [WordController new];
        navi = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sc];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.contentLB.text = [self.wordVM contentForRow:indexPath.row];
    NSString *title = [self.wordVM zanNumForRow:indexPath.row];
    [cell.zanBtn setTitle:title forState:UIControlStateNormal];
    [cell.zanBtn bk_addEventHandler:^(id sender) {
        [cell.zanBtn setTitle:[NSString stringWithFormat:@"%ld",(title.integerValue+1)] forState:UIControlStateNormal];
        [self showSuccessWithMsg:@"点赞成功"];
    } forControlEvents:UIControlEventTouchUpInside];
    cell.dateLB.text = [self.wordVM dateForRow:indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WordDetailController *vc = [[WordDetailController alloc] initWithContent:[self.wordVM contentForRow:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (WordViewModel *)wordVM {
    if(_wordVM == nil) {
        _wordVM = [[WordViewModel alloc] init];
    }
    return _wordVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[WordCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.wordVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.wordVM getMoreDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_footer endRefreshing];
            }];
        }];
    }
    return _tableView;
}

- (UISegmentedControl *)sc {
    if(_sc == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"段子",@"图片", nil];
        _sc = [[UISegmentedControl alloc] initWithItems:arr];
        _sc.frame = CGRectMake(0, 0, 150, 30);
        _sc.selectedSegmentIndex = 0;
        _sc.tintColor = [UIColor whiteColor];
        [_sc bk_addEventHandler:^(id sender) {
            NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [naviVCs removeLastObject];
            PicController *vc = [PicController new];
            [naviVCs addObject:vc];
            self.navigationController.viewControllers = naviVCs;
        } forControlEvents:UIControlEventValueChanged];
        [self.navigationItem setTitleView:_sc];
    }
    return _sc;
}

@end
