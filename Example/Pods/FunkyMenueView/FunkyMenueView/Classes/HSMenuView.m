//
//  HSMenuView.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSMenuView.h"
#import "HSUpDownBtn.h"


#define kMenueWidth 60
#define kMenueMargin 20

@implementation HSMenuView

-(void)setMenueModels:(NSArray<id<HSMenueModelProtocol>> *)menueModels {
    _menueModels = menueModels;
    
    // 1. 移除所有之前的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = menueModels.count;
    for(int i = 0;i < count; i++)
    {
        id<HSMenueModelProtocol> model= menueModels[i];
        HSUpDownBtn *btn = [[HSUpDownBtn alloc] init];
        if (self.loadBlock) {
            self.loadBlock(btn, [NSURL URLWithString:model.imageURL]);
        }
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.tag = self.subviews.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
    }
    
    [self setNeedsLayout];
    
}

- (void)btnClick: (HSUpDownBtn *)upDownBtn {
    
    NSInteger tag = upDownBtn.tag;
    id<HSMenueModelProtocol> menueModel = self.menueModels[tag];
    if(menueModel.clickBlock != nil)
    {
        menueModel.clickBlock();
    }
    
}



-(void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.menueModels.count;
    CGFloat h = self.frame.size.height;
    for(int i = 0; i < count; i++)
    {
        UIView *subView = self.subviews[i];
        subView.frame = CGRectMake(i * (kMenueWidth + kMenueMargin) + kMenueMargin, 0, kMenueWidth, h);
    }
    
    self.contentSize = CGSizeMake((kMenueWidth + kMenueMargin) * count + kMenueMargin, 0);
}


@end
