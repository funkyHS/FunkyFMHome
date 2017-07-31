//
//  HSScrollPicProtocol.h
//  FunkyScrollPicView
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HSScrollPicProtocol <NSObject>


// 广告图片URL
@property (nonatomic, copy, readonly) NSURL *adImgURL;


// 点击执行的代码块
@property (nonatomic, copy) void(^clickImgBlock)();



@end
