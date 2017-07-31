//
//  HSRecommendDataTool.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HSAdPicModel;
#import "HSGroupModel.h"

@interface HSRecommendDataTool : NSObject


+ (instancetype)shareInstance;

// 获取发现模块的  "广告列表"
- (void)getAdList:(void(^)(NSArray *adMs, NSError *error))result;


// 获取发现模块的 "图文菜单"
- (void)getPicMenueList:(void(^)(NSArray *menuePicMs, NSError *error))result;

// 获取发现模块的  "小编推荐"
- (void)getEditorRecommendAlbums:(void(^)(HSGroupModel *groupM, NSError *error))result;

// 获取发现模块的  "现场直播"
- (void)getLiveMs:(void(^)(HSGroupModel *groupM, NSError *error))result;

// 获取发现模块的  "精品听单"
- (void)getSpecialColumnMs:(void(^)(HSGroupModel *groupM, NSError *error))result;

// 获取发现模块的  "推广"
- (void)getTuiGuangMs:(void(^)(HSGroupModel *groupM, NSError *error))result;

// 获取发现模块的  "听广州"
- (void)getCityAlbums:(void(^)(HSGroupModel *groupM, NSError *error))result;

// 获取发现模块的  "热门推荐-听其他"
- (void)getHotRecommendsAlbums:(void(^)(NSArray <HSGroupModel *> *groupMs, NSError *error))result;






@end
