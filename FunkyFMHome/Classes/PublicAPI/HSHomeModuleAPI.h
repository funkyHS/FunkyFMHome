//
//  HSHomeModuleAPI.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSHomeModuleAPI : NSObject

+ (instancetype)shareInstance;


// 获取首页控制器
@property (nonatomic, weak, readonly) UIViewController *homeVC;


@end
