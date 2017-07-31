//
//  HSRecommendTVC.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSRecommendTVC.h"
#import "Base.h"
#import "HSRecommendDataTool.h"
#import "HSScrollPicView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "HSAdPicModel.h"
#import "HSMenuView.h"
#import "UIView+HSLayout.h"
#import "HSSpecialColumnCell.h"
#import "HSRecommendCell.h"
#import "HSAdPicTextCell.h"



@interface HSRecommendTVC ()

@property (nonatomic, strong) HSScrollPicView *adPicView;

@property (nonatomic, strong) HSMenuView *menueView;

@property (nonatomic, strong) NSMutableArray *listMs;


@end

@implementation HSRecommendTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    // 设置图片轮播器
    [self.tableView.tableHeaderView addSubview:self.adPicView];
    self.adPicView.frame = CGRectMake(0, 0, kScreenWidth, 150);
    
    
    // 设置菜单栏
    [self.tableView.tableHeaderView addSubview:self.menueView];
    self.menueView.frame = CGRectMake(0, 150, kScreenWidth, 100);


    
    
    // 加载广告
    kWeakSelf;
    [[HSRecommendDataTool shareInstance] getAdList:^(NSArray *adMs, NSError *error) {
        
        for (int i = 0; i < adMs.count; i ++) {
            HSAdPicModel *adM = adMs[i];
            __weak HSAdPicModel *weakAdM = adM;
            weakAdM.clickImgBlock = ^{
               
                /*
                NSInteger type = weakAdM.focusImageM.type;
                
                NSInteger albumID = weakAdM.focusImageM.albumId;
                
                UINavigationController *nav = self.navigationController;
                
                if (type == 9) {
                    NSLog(@"听单处理");
                }
                
                if (type == 3) {
                    NSLog(@"播放器界面");
                    NSString *albumID = [NSString stringWithFormat:@"%zd", weakAdM.focusImageM.trackId];
                    //kPresentToPlayer(albumID)
                    
                }else if (type == 2) {
                    NSLog(@"跳转到专辑详情");
                    // 跳转到专辑详情
                    UINavigationController *nav = self.navigationController;
                    NSString *albumIDStr = [NSString stringWithFormat:@"%zd", albumID];
                    //kJumpToAlbumDetail(albumIDStr, nav)
                }else if (type == 4) {
                    
                    // 打开网页
//                    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:weakAdM.focusImageM.url]];
//                    sfvc.title = @"商城";
//                    [nav pushViewController:sfvc animated:YES];
                }
                
                */
                
            };
        }
        
        weakSelf.adPicView.picModels = adMs;
    }];
    
    
    // 加载 图文菜单列表
    [[HSRecommendDataTool shareInstance] getPicMenueList:^(NSArray *menuePicMs, NSError *error) {
        weakSelf.menueView.menueModels = menuePicMs;
    }];
    
    
    // 加载 小编推荐
    [[HSRecommendDataTool shareInstance] getEditorRecommendAlbums:^(HSGroupModel *groupM, NSError *error) {
        NSLog(@"%@", groupM.title);
        groupM.sortID = 1;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];
    
    
    
    // 加载 现场直播
    [[HSRecommendDataTool shareInstance] getLiveMs:^(HSGroupModel *groupM, NSError *error) {
        NSLog(@"%@", groupM.liveMs);
        groupM.sortID = 2;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];
    
    
    // 加载 精品听单
    [[HSRecommendDataTool shareInstance] getSpecialColumnMs:^(HSGroupModel *groupM, NSError *error) {
        groupM.sortID = 4;
        NSLog(@"%@", groupM);
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];
    
    // 加载 推广
    [[HSRecommendDataTool shareInstance] getTuiGuangMs:^(HSGroupModel *groupM, NSError *error) {
        groupM.sortID = 5;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];
    
    // 加载  听"广州"
    [[HSRecommendDataTool shareInstance] getCityAlbums:^(HSGroupModel *groupM, NSError *error) {
        groupM.sortID = 3;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
        
    }];
    
    // 加载 "热门推荐"
    [[HSRecommendDataTool shareInstance] getHotRecommendsAlbums:^(NSArray<HSGroupModel *> *groupMs, NSError *error) {
        
        [weakSelf.listMs addObjectsFromArray:groupMs];
        [weakSelf.tableView reloadData];
        
    }];
    

    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HSGroupModel *groupM = self.listMs[indexPath.row];
    
    UITableViewCell *cell;
    
    if (groupM.cellType == CellTypeList3) {
        
        cell = [HSRecommendCell cellWithTableView:tableView];
        [(HSRecommendCell *)cell setGroupM:groupM];
        
    }else if(groupM.cellType == CellTypeList1) {
        
        cell = [HSAdPicTextCell cellWithTableView:tableView];
        [(HSAdPicTextCell *)cell setGroupM:groupM];
        
    }else if(groupM.cellType == CellTypeList2) {
        
        cell = [HSSpecialColumnCell cellWithTableView:tableView];
        [(HSSpecialColumnCell *)cell setGroupM:groupM];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSGroupModel *groupM = self.listMs[indexPath.row];
    
    if (groupM.cellType == CellTypeList1) {
        return 210;
    }
    
    if (groupM.cellType == CellTypeList3) {
        return 240;
    }
    
    if (groupM.cellType == CellTypeList2) {
        return 210;
    }
    
    return 0;
}


#pragma mark - 懒加载

-(HSScrollPicView *)adPicView {
    
    if (_adPicView == nil) {
        
        HSScrollPicView *adPicView = [HSScrollPicView picViewWithLoadImageBlock:^(UIImageView *imageView, NSURL *url) {
            [imageView sd_setImageWithURL:url];
        }];
        _adPicView = adPicView;
    }
    return _adPicView;
}
-(HSMenuView *)menueView {
    
    if(_menueView == nil)
    {
        HSMenuView *menueView = [[HSMenuView alloc] initWithFrame:CGRectZero];
        menueView.loadBlock = ^(UIButton *imageBtn, NSURL *url){
            [imageBtn sd_setImageWithURL:url forState:UIControlStateNormal];
        };
        _menueView = menueView;
    }
    return _menueView;
}
-(NSMutableArray *)listMs {
    if (_listMs == nil) {
        _listMs = [NSMutableArray array];
    }
    
    // 根据模型的sortID进行排序
    [_listMs sortUsingComparator:^NSComparisonResult(HSGroupModel *obj1, HSGroupModel *obj2) {
        
        if (obj1.sortID < obj2.sortID) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    
    return _listMs;
}


@end
