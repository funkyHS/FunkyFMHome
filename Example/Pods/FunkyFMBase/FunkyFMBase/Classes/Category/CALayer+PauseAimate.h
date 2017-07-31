//
//  CALayer+PauseAimate.h
//  FunkyFM
//
//  Created by 胡晟 on 2017/5/27.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
