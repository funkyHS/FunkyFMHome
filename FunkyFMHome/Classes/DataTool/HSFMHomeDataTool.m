//
//  HSFMHomeDataTool.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSFMHomeDataTool.h"
#import "HSSessionManager.h"
#import "Sington.h"
#import "Base.h"



@interface HSFMHomeDataTool()

@property (nonatomic, strong) HSSessionManager *manager;

@end


@implementation HSFMHomeDataTool
singtonImplement(HSFMHomeDataTool);

- (HSSessionManager *)manager {
    if (!_manager) {
        _manager = [[HSSessionManager alloc] init];
    }
    return _manager;
}

- (void)getHomeTabs: (void(^)(NSArray <NSString *>*tabMs))resultBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/tabs"];
    NSDictionary *param = @{
                            @"device": @"iPhone"
                            };
    
    [self.manager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        
        NSArray <NSDictionary *>*dicArray = (NSArray <NSDictionary *>*)responseObject[@"tabs"][@"list"];
        NSMutableArray *menueItems = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            
            [menueItems addObject:dic[@"title"]];
            
        }
        resultBlock(menueItems);
        
    }];
    
    
}


@end
