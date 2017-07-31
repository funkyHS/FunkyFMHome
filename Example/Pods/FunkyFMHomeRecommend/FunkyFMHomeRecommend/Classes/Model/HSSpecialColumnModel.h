//
//  HSSpecialColumnModel.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSSpecialColumnModel : NSObject


@property (nonatomic, assign)  NSInteger columnType;
@property (nonatomic, assign)  NSInteger specialId;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *subtitle;
@property (nonatomic, copy)  NSString *footnote;
@property (nonatomic, copy)  NSString *coverPath;
@property (nonatomic, copy)  NSString *contentType;


@end
