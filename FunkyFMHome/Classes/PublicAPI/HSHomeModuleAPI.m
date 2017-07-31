//
//  HSHomeModuleAPI.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSHomeModuleAPI.h"
#import "HomeVC.h"

@implementation HSHomeModuleAPI

static HSHomeModuleAPI *_shareInstance;
+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [[HSHomeModuleAPI alloc] init];
    }
    return _shareInstance;
}


- (UIViewController *)homeVC {
    return [[HomeVC alloc] init];
}

@end
