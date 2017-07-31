//
//  HSMenueModelProtocol.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HSMenueModelProtocol <NSObject>


@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) void(^clickBlock)();


@end
