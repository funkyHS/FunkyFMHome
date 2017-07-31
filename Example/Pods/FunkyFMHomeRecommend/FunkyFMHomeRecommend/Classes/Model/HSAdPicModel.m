//
//  HSAdPicModel.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSAdPicModel.h"
#import "HSScrollPicProtocol.h"

@interface HSAdPicModel()<HSScrollPicProtocol>

@end

@implementation HSAdPicModel


-(void)setFocusImageM:(HSFocusImageModel *)focusImageM {
    _focusImageM = focusImageM;
    self.adImgURL = [NSURL URLWithString:_focusImageM.pic];
}

-(void)setLiveM:(HSLiveModel *)liveM {
    _liveM = liveM;
    self.adImgURL = [NSURL URLWithString:_liveM.coverPath];
}

-(void)setTuiguangM:(HSTuiguangModel *)tuiguangM
{
    _tuiguangM = tuiguangM;
    self.adImgURL = [NSURL URLWithString:_tuiguangM.cover];
}


@end
