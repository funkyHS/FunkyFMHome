//
//  NSObject+HSBundle.m
//  FunkyFM
//
//  Created by 胡晟 on 2017/6/11.
//  Copyright © 2017年 胡晟. All rights reserved.
//

#import "NSObject+HSBundle.h"

@implementation NSObject (HSBundle)

+ (NSBundle *)currentBundle {
    
    NSBundle *bundle = [NSBundle bundleForClass:self];
    return bundle;

}

@end
