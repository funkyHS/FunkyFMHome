//
//  HSItemCell.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSItemCell.h"
#import "UIImageView+HSExtension.h"

@interface HSItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *payIcon;

@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation HSItemCell


-(void)setItemInCellModel:(HSItemInCellModel *)itemInCellModel
{
    _itemInCellModel = itemInCellModel;
    
    
    self.payIcon.hidden = [itemInCellModel.isPaid boolValue];
    NSURL *url = [NSURL URLWithString:itemInCellModel.albumCoverUrl290];
    [self.albumCoverImageView setURLImageWithURL:url placeHoldImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] isCircle:NO];
    self.titleLabel.text = itemInCellModel.trackTitle;
    self.detailLabel.text = itemInCellModel.title;
    
    
}


@end
