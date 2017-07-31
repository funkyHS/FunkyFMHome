//
//  HomeVC.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HomeVC.h"
#import "HSSementBarVC.h"
#import "Base.h"
#import "HSFMHomeDataTool.h"


#import "HSRecommendTVC.h"
//#import "HSClassificationTVC.h"
//#import "HSRadioBroadcaseTVC.h"
//#import "HSBillBoardTVC.h"
//#import "HSFMAnchorTVC.h"



@interface HomeVC ()

@property (nonatomic, weak) HSSementBarVC *segmentBarVC;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = kCommonColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    
    
    
    [[HSFMHomeDataTool shareInstance] getHomeTabs:^(NSArray <NSString *>*tabMs) {
        
        [self.segmentBarVC setUpWithItems:tabMs childVCs:@[[HSRecommendTVC new], [UIViewController new], [UIViewController new], [UIViewController new], [UIViewController new]]];
        
    }];

    
    // 更新 segmentBar 的样式
    [self.segmentBarVC.segmentBar updateWithConfig:^(HSSegmentBarConfig *config) {
        config.segmentBarBackColor = [UIColor whiteColor];
    }];

    
}


#pragma mark - 懒加载

- (HSSementBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        HSSementBarVC *vc = [[HSSementBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}


@end
