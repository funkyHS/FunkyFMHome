//
//  HSCellInCell.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSSpecialColumnModel.h"


@interface HSCellInCell : UITableViewCell


@property (nonatomic, strong) HSSpecialColumnModel *specialColumnM;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
