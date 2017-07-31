//
//  HSSegmentBarConfig.m
//  FunkySegmentBar
//
//  Created by 胡晟 on 2017/6/12.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSSegmentBarConfig.h"

@implementation HSSegmentBarConfig

+ (instancetype)defaultConfig {
    
    HSSegmentBarConfig *config = [[HSSegmentBarConfig alloc] init];
    config.segmentBarBackColor = [UIColor clearColor];
    config.segNormalFont = [UIFont systemFontOfSize:12];
    config.segSelectedFont = [UIFont systemFontOfSize:12];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 10;
    config.barBtnW = 0;
    config.limitMargin = 25;
    config.showMoreBtnW = -1;
    
    return config;
    
}

-(void)setIsShowMore:(BOOL)isShowMore {
    _isShowMore = isShowMore;
    
    self.showMoreBtnW = _isShowMore? 55 : -1;
}

- (HSSegmentBarConfig *(^)(UIColor *))itemNC {
    
    return ^(UIColor *color){
        self.itemNormalColor = color;
        return self;
    };
    
}

-(HSSegmentBarConfig *(^)(UIColor *))itemSC {
    return ^(UIColor *color){
        self.itemSelectColor = color;
        return self;
    };
}

@end
