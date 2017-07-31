//
//  HSMenueModel.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HSMenueModel : NSObject


@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy, getter=imageURL) NSString *coverPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^clickBlock)();

@end
