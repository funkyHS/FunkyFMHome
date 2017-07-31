//
//  HSSegmentBarConfig.h
//  FunkySegmentBar
//
//  Created by 胡晟 on 2017/6/12.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSSegmentBarConfig : NSObject


+ (instancetype)defaultConfig;

/** 控制是否显示更多*/
@property (nonatomic, assign) BOOL isShowMore;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *segmentBarBackColor;

/** 选项颜色(普通) */
@property (nonatomic, strong) UIColor *itemNormalColor;

/** 选项颜色(选中) */
@property (nonatomic, strong) UIColor *itemSelectColor;

/** 选项字体(普通) */
@property (nonatomic, strong) UIFont *segNormalFont;

/** 选项字体(选中) */
@property (nonatomic, strong) UIFont *segSelectedFont;

/** 指示器颜色, 默认红色 */
@property (nonatomic, strong) UIColor *indicatorColor;

/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/** 指示器的额外宽度(在跟随字体宽度之外的额外宽度) */
@property (nonatomic, assign) CGFloat indicatorExtraW;

/** bar按钮宽度（默认是根据按钮字的宽度自适应按钮的宽度） */
@property (nonatomic, assign) CGFloat barBtnW;

/** 更多按钮宽度（默认是55） */
@property (nonatomic, assign) CGFloat showMoreBtnW;

/** 选项卡之间的最小间距 */
@property (nonatomic, assign) CGFloat limitMargin;


// 链式编程的改法
- (HSSegmentBarConfig *(^)(UIColor *color))itemNC;
- (HSSegmentBarConfig *(^)(UIColor *color))itemSC;



@end

