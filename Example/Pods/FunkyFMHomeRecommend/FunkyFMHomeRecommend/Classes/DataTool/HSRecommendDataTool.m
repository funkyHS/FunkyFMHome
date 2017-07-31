//
//  HSRecommendDataTool.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSRecommendDataTool.h"
#import "HSSessionManager.h"
#import "Base.h"
#import "MJExtension.h"
#import "Sington.h"
#import "HSAdPicModel.h"
#import "HSMenueModel.h"
#import "HSGroupModel.h"

@interface HSRecommendDataTool()

@property (nonatomic, strong) HSSessionManager *sessionManager;

@end


@implementation HSRecommendDataTool

singtonImplement(HSRecommendDataTool)


-(HSSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[HSSessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)getAdList:(void(^)(NSArray *adMs, NSError *error))result {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        NSArray *focusImageMs = [HSFocusImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"focusImages"][@"list"]];
        
        NSMutableArray *adPicMs = [NSMutableArray array];
        for (HSFocusImageModel *focusImageM in focusImageMs) {
            HSAdPicModel *adPicM = [[HSAdPicModel alloc] init];
            adPicM.focusImageM = focusImageM;
            [adPicMs addObject:adPicM];
        }
        
        
        result(adPicMs, error);
        
        
    }];
}

- (void)getPicMenueList:(void(^)(NSArray *menuePicMs, NSError *error))result {
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray *menuePicMs = [HSMenueModel mj_objectArrayWithKeyValuesArray:responseObject[@"discoveryColumns"][@"list"]];
        
        result(menuePicMs, error);
    }];
        
}



- (void)getEditorRecommendAlbums:(void(^)(HSGroupModel *groupM, NSError *error))result {
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        
        [HSGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [HSItemInCellModel class]
                     };
        }];
        
        
        NSDictionary *dic = responseObject[@"editorRecommendAlbums"];
        HSGroupModel *groupM = [HSGroupModel mj_objectWithKeyValues:dic];
        groupM.cellType = CellTypeList3;
        result(groupM, error);
        
        
    }];
    
}


- (void)getLiveMs:(void(^)(HSGroupModel *groupM, NSError *error))result {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-activity-web/v3/activity/recommend"];
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"%@", responseObject);
        
        NSArray *liveMs = [HSLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        NSLog(@"%@", liveMs);
        HSGroupModel *groupM = [[HSGroupModel alloc] init];
        groupM.cellType = CellTypeList1;
        groupM.title = @"现场直播";
        groupM.hasMore = true;
        groupM.liveMs = liveMs;
        result(groupM, error);
        
    }];
    
}


- (void)getSpecialColumnMs:(void(^)(HSGroupModel *groupM, NSError *error))result {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        
        [HSGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [HSSpecialColumnModel class]
                     };
        }];
        
        
        NSDictionary *dic = responseObject[@"specialColumn"];
        HSGroupModel *groupM = [HSGroupModel mj_objectWithKeyValues:dic];
        groupM.cellType = CellTypeList2;
        
        result(groupM, error);
        
        
    }];
    
    
    
    
}

- (void)getTuiGuangMs:(void(^)(HSGroupModel *groupM, NSError *error))result {
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kAdUrl, @"/ting/feed"];
    
    NSDictionary *param = @{
                            @"appid": @"0",
                            @"device": @"iPhone",
                            @"name": @"find_native",
                            @"network": @"WIFI",
                            @"operator": @3,
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"%@", responseObject);
        [HSTuiguangModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return  @{
                      @"Description": @"description",
                      @"Auto" : @"auto"
                      };
        }];
        
        NSArray *tuiguangMs = [HSTuiguangModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        HSGroupModel *groupM = [[HSGroupModel alloc] init];
        groupM.cellType = CellTypeList1;
        groupM.title = @"推广";
        groupM.hasMore = true;
        
        groupM.tuiguangMs = tuiguangMs;
        
        
        result(groupM, error);
        
        
    }];
    
    
}

- (void)getCityAlbums:(void(^)(HSGroupModel *groupM, NSError *error))result {
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"code": @"43_440000_4401",
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        
        
        [HSGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [HSItemInCellModel class]
                     };
        }];
        
        HSGroupModel *groupM = [HSGroupModel mj_objectWithKeyValues:responseObject[@"cityColumn"]];
        
        groupM.cellType = CellTypeList3;
        result(groupM, error);
        
        
    }];
    
    
}

- (void)getHotRecommendsAlbums:(void(^)(NSArray <HSGroupModel *> *groupMs, NSError *error))result {
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"code": @"43_440000_4401",
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        
        
        [HSGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [HSItemInCellModel class]
                     };
        }];
        
        
        NSArray *groupMs = [HSGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"hotRecommends"][@"list"]];
        
        [groupMs enumerateObjectsUsingBlock:^(HSGroupModel *groupM, NSUInteger idx, BOOL * _Nonnull stop) {
            groupM.sortID = 10 + idx;
            groupM.cellType = CellTypeList3;
        }];
        
        
        result(groupMs, error);
        
        
    }];
}

/*

- (void)getRecommendEditorList:(void (^)(NSArray<HSNominateEditorModel *>*editorMs, NSError *error))result {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/recommend/editor"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageId": @"1",
                            @"pageSize": @"20"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray *editorMs = [HSNominateEditorModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        result(editorMs, error);
        
    }];
}

*/

@end
