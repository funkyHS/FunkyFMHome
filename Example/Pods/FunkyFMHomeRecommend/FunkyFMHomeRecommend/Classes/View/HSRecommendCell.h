//
//  HSRecommendCell.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSGroupModel.h"

@interface HSRecommendCell : UITableViewCell

@property (nonatomic, strong) HSGroupModel *groupM;

+ (instancetype)cellWithTableView: (UITableView *)tableView;


@end
