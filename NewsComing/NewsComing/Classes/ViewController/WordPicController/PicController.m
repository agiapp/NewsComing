//
//  PicController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "PicController.h"
#import "PicViewModel.h"
#import "WordController.h"
#import "PicCell.h"
#import "PicDetailController.h"

@interface PicController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UISegmentedControl *sc;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PicViewModel *picVM;

@end

@implementation PicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView.mj_header beginRefreshing];
    [self sc];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.picVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconIV.imgView setImageWithURL:[self.picVM iconURLsForRow:indexPath.row][0] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.titleLB.text = [self.picVM titleForRow:indexPath.row];
    cell.browseNum.text = [self.picVM browseNumForRow:indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PicDetailController *vc = [[PicDetailController alloc] initWithPicModel:[self.picVM modelForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UISegmentedControl *)sc {
    if(_sc == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"段子", @"图片", nil];
        _sc = [[UISegmentedControl alloc] initWithItems:arr];
        _sc.frame = CGRectMake(0, 0, 150, 30);
        _sc.tintColor = [UIColor whiteColor];
        _sc.selectedSegmentIndex = 1;
        [_sc bk_addEventHandler:^(id sender) {
            _sc.selectedSegmentIndex = 1;
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [mArr removeLastObject];
            WordController *vc = [WordController new];
            [mArr addObject:vc];
            self.navigationController.viewControllers = mArr;
            
        } forControlEvents:UIControlEventValueChanged];
        
        [self.navigationItem setTitleView:_sc];
    }
    return _sc;
}

- (PicViewModel *)picVM {
    if(_picVM == nil) {
        _picVM = [[PicViewModel alloc] init];
    }
    return _picVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[PicCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.picVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.picVM getMoreDataCompletionHandler:^(NSError *error) {
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
