//
//  HSMenuView.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSMenueModelProtocol.h"

typedef void(^HSMenueViewLoadImageBlock)(UIButton *imageBtn, NSURL *url);

@interface HSMenuView : UIScrollView

@property (nonatomic, copy) HSMenueViewLoadImageBlock loadBlock;


@property (nonatomic, strong) NSArray <id<HSMenueModelProtocol>>*menueModels;



@end
