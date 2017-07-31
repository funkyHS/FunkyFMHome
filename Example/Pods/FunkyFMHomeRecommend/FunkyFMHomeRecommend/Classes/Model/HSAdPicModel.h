//
//  HSAdPicModel.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSFocusImageModel.h"
#import "HSLiveModel.h"
#import "HSTuiguangModel.h"
//#import "HSClassItemModel.h"



@interface HSAdPicModel : NSObject

@property (nonatomic, strong) HSFocusImageModel *focusImageM;

@property (nonatomic, strong) HSLiveModel *liveM;

@property (nonatomic, strong) HSTuiguangModel *tuiguangM;

//@property (nonatomic, strong) HSClassItemModel *classItemM;



/**
 *  广告图片URL
 */
@property (nonatomic, copy) NSURL *adImgURL;

/**
 *  点击广告, 需要跳转的URL
 */
@property (nonatomic, copy) NSURL *adLinkURL;

/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickImgBlock)();


@end
