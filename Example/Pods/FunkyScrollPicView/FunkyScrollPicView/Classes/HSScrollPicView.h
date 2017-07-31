//
//  HSScrollPicView.h
//  FunkyScrollPicView
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSScrollPicProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol HSScrollPicViewDelegate <NSObject>

- (void)adPicViewDidSelectedPicModel: (id <HSScrollPicProtocol>)picM;

@end



@interface HSScrollPicView : UIView


+ (instancetype)picViewWithLoadImageBlock: (LoadImageBlock)loadBlock;


// 用来展示图片的数据源
@property (nonatomic, strong) NSArray <id <HSScrollPicProtocol>>*picModels;

// 用于加载图片的代码块, 必须赋值
@property (nonatomic, copy) LoadImageBlock loadBlock;

// 用于告知外界, 当前滚动到的是哪个广告数据模型
@property (nonatomic, strong) id<HSScrollPicViewDelegate> delegate;


@end
