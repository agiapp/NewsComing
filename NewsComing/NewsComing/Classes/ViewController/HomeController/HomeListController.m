//
//  HomeListController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeListController.h"
#import "HomeCell.h"
#import "HomeViewModel.h"
#import "HomeDetailController.h"
#import "iCarousel.h"

@interface HomeListController () <UITableViewDataSource, UITableViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) HomeViewModel *homeVM;

@end

@implementation HomeListController
{
    iCarousel *_ic;
    NSTimer *_timer;
    UIPageControl *_pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

- (UIView *)configHeadView {
    [_timer invalidate];
    if (!self.homeVM.hasHeadImg) {
        return nil;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kWindowW*375/750)];
    
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _ic.dataSource = self;
    _ic.delegate = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = 6;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.userInteractionEnabled = NO;
    [headView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(0);
    }];
    
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
    } repeats:YES];
    
    return headView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if([self.homeVM mediaTypeForRow:indexPath.row] == 6) {
        cell.iconIV.imgView.image = [UIImage imageNamed:@"car"];
    }else {
        [cell.iconIV.imgView setImageWithURL:[self.homeVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    }
    
    cell.titleLB.text = [self.homeVM titleForRow:indexPath.row];
    cell.dateLB.text = [self.homeVM dateForRow:indexPath.row];
    cell.commentNumLB.text = [self.homeVM commentNumForRow:indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HomeDetailController *vc = [[HomeDetailController alloc] initWithID:[self.homeVM IDForRow:indexPath.row]];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <iCarouselDataSource>
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.homeVM.headImgURLs.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*375/750)];
        UIImageView *imgView = [UIImageView new];
        imgView.tag = 100;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [view addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imgView = (UIImageView *)[view viewWithTag:100];
    [imgView setImageWithURL:self.homeVM.headImgURLs[index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    
    return view;
}

#pragma mark - <iCarouselDelegate>
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    //循环滚动
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    _pageControl.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    HomeDetailController *vc = [[HomeDetailController alloc] initWithID:[self.homeVM IDForRow:index]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (HomeViewModel *)homeVM {
    if(_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] initWithType:self.infoType.integerValue];
    }
    return _homeVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.homeVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    _tableView.tableHeaderView = [self configHeadView];
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            [self.homeVM getMoreDataCompletionHandler:^(NSError *error) {
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
