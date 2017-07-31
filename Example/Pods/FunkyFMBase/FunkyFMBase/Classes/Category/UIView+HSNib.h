//
//  UIView+HSNib.h
//  FunkyFM
//
//  Created by 胡晟 on 2017/6/11.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HSNib)

+ (instancetype)loadFromNib;

/**
 *  返回当前视图, 所处的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)currentViewController;



@end
