//
//  HSFMHomeDataTool.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSFMHomeDataTool : NSObject

+ (instancetype)shareInstance;

- (void)getHomeTabs: (void(^)(NSArray <NSString *>*tabMs))resultBlock;

@end
