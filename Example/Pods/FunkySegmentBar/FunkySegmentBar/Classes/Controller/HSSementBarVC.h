//
//  HSSementBarVC.h
//  FunkySegmentBar
//
//  Created by 胡晟 on 2017/6/12.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HSSegmentBar.h"
@interface HSSementBarVC : UIViewController


@property (nonatomic, weak) HSSegmentBar *segmentBar;


- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;


@end
