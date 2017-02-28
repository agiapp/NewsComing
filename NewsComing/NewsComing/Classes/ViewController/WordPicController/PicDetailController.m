//
//  PicDetailController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "PicDetailController.h"
#import <MWPhotoBrowser.h>

@interface PicDetailController () <MWPhotoBrowserDelegate>

@end

@implementation PicDetailController

- (instancetype)initWithPicModel:(PicModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [BarItem addBackItemToVC:self];
    
    MWPhotoBrowser *pb = [[MWPhotoBrowser alloc] initWithDelegate:self];
    NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [naviVCs removeLastObject];
    [naviVCs addObject:pb];
    self.navigationController.viewControllers = naviVCs;
}

#pragma mark - <MWPhotoBrowserDelegate>
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 3;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:self.model.pics[index]]];
    return photo;
}

@end
